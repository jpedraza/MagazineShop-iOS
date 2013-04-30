//
//  MSMagazineView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 20/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineView.h"


@interface MSMagazineView ()

@property (nonatomic, strong) MSMagazineListSingleView *magazineSingleView;
@property (nonatomic, strong) MSMagazineListMediumView *magazineListView;
@property (nonatomic, strong) MSMagazineListDenseView *magazineDenseView;

@property (nonatomic, strong) MSMagazineListView *currentMagazineView;

@property (nonatomic, strong) NSMutableDictionary *products;
@property (nonatomic, strong) NSArray *productsInfo;
@property (nonatomic) NSInteger pricedProductCount;
@property (nonatomic) NSInteger pricedProductCountFinished;

@property (nonatomic, strong) id <MSMagazineListViewDelegate> magazineDelegate;

@property (nonatomic) BOOL firstStart;

@end


@implementation MSMagazineView


#pragma mark Creating elements

- (void)createMagazineSingleView {
    _magazineSingleView = [[MSMagazineListSingleView alloc] initWithFrame:self.bounds];
    [_magazineSingleView setAlpha:0];
    [_magazineSingleView setAutoresizingWidthAndHeight];
    [_magazineSingleView setDataSource:self];
    [_magazineSingleView setDelegate:_magazineDelegate];
    [self addSubview:_magazineSingleView];
    _currentMagazineView = _magazineSingleView;
}

- (void)createMagazineListView {
    _magazineListView = [[MSMagazineListMediumView alloc] initWithFrame:self.bounds];
    if (!_firstStart) [_magazineListView setAlpha:0];
    [_magazineListView setAutoresizingWidthAndHeight];
    [_magazineListView setDataSource:self];
    [_magazineListView setDelegate:_magazineDelegate];
    [self addSubview:_magazineListView];
    _currentMagazineView = _magazineListView;
    _firstStart = NO;
}

- (void)createMagazineDenseView {
    _magazineDenseView = [[MSMagazineListDenseView alloc] initWithFrame:self.bounds];
    [_magazineDenseView setAlpha:0];
    [_magazineDenseView setAutoresizingWidthAndHeight];
    [_magazineDenseView setDataSource:self];
    [_magazineDenseView setDelegate:_magazineDelegate];
    [self addSubview:_magazineDenseView];
    _currentMagazineView = _magazineDenseView;
}

- (void)createAllElements {
    _firstStart = YES;
    _listViewType = MSConfigMainMagazineListViewTypeList;
    
    [super createAllElements];
    [self createMagazineListView];
}

#pragma mark Settings

- (void)setMagazineDelegate:(id<MSMagazineListViewDelegate>)delegate {
    _magazineDelegate = delegate;
    [_magazineListView setDelegate:_magazineDelegate];
}

- (void)removeAllViews {
    [_magazineSingleView removeFromSuperview];
    _magazineSingleView = nil;

    [_magazineListView removeFromSuperview];
    _magazineListView = nil;

    [_magazineDenseView removeFromSuperview];
    _magazineDenseView = nil;
}

- (void)animateNewMagazineViewOn {
    [_currentMagazineView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        [_currentMagazineView setAlpha:1];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showMagazineSingleView {
    [self removeAllViews];
    [self createMagazineSingleView];
    [self animateNewMagazineViewOn];
}

- (void)showMagazineListView {
    [self removeAllViews];
    [self createMagazineListView];
    [self animateNewMagazineViewOn];
}

- (void)showMagazineDenseView {
    [self removeAllViews];
    [self createMagazineDenseView];
    [self animateNewMagazineViewOn];
}

- (void)showNewMagazineView {
    SEL selector = nil;
    switch (_listViewType) {
        case MSConfigMainMagazineListViewTypeSigle:
            selector = @selector(showMagazineSingleView);
            break;
            
        case MSConfigMainMagazineListViewTypeList:
            selector = @selector(showMagazineListView);
            break;
            
        case MSConfigMainMagazineListViewTypeDense:
            selector = @selector(showMagazineDenseView);
            break;
            
        default:
            break;
    }
    [self performSelectorOnMainThread:selector withObject:nil waitUntilDone:YES];
}

- (void)setListViewType:(MSConfigMainMagazineListViewType)listViewType {
    if (_listViewType != listViewType) {
        _listViewType = listViewType;
        [_currentMagazineView hide];
    }
}

#pragma mark Data

- (void)reloadData {
    [_currentMagazineView reloadData];
}

- (void)loadProducts {
    if ([_delegate respondsToSelector:@selector(magazineViewDidStartLoadingData:)]) {
        [_delegate magazineViewDidStartLoadingData:self];
    }
    NSString *url = [kMSConfigBaseUrl stringByAppendingPathComponent:@"api/issues.json"];
    MSDownload *download = [[MSDownload alloc] initWithURL:url withDelegate:self andCacheLifetime:MSDownloadCacheLifetimeSession];
    [kDownloadOperation addOperation:download];
}

#pragma mark Product cell delegate methods

- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestActionFor:(MSProduct *)product {
    if (![MSInAppPurchase isProductPurchased:product]) {
        [kMSInAppPurchase buyProduct:product.product];
        [cell.actionButton setTitle:MSLangGet(@"Buying") forState:UIControlStateNormal];
        [cell.actionButton setEnabled:NO];
    }
    else {
        if ([product productAvailability] == MSProductAvailabilityNotPresent) {
            [product downloadIssueWithDelegate:self];
        }
    }
}

- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestDetailFor:(MSProduct *)product {
    
}

- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestCoverFor:(MSProduct *)product {
    
}

#pragma mark Issue download delegate methods

- (void)product:(MSProduct *)product didDownloadItem:(NSInteger)item of:(NSInteger)totalItems {
    NSLog(@"Downloaded item: %d of %d (%@)", item, totalItems, ([product isPageWithIndex:item availableInSize:MSProductPageSize1024] ? @"Ok" : @"Fail"));
    
}

#pragma mark StoreKit delegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    _pricedProductCountFinished++;
    for (SKProduct *p in response.products) {
        [_products setObject:p forKey:p.productIdentifier];
    }
    if (_pricedProductCount == _pricedProductCountFinished) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *info in _productsInfo) {
            MSProduct *product = [[MSProduct alloc] init];
            [product fillDataFromDictionary:info];
            [product setProduct:[_products objectForKey:product.identifier]];
            [arr addObject:product];
        }
        [[MSDataHolder sharedObject] setProducts:arr];
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        if ([_delegate respondsToSelector:@selector(magazineViewDidFinishLoadingData:)]) {
            [(NSObject *)_delegate performSelectorOnMainThread:@selector(magazineViewDidFinishLoadingData:) withObject:self waitUntilDone:NO];
        }
    }
}

#pragma mark Magazine list view datasource methods

- (NSDictionary *)magazineListViewProductsForCollectionView:(MSMagazineListView *)view {
    return _products;
}

- (NSArray *)magazineListViewProductsInfoForCollectionView:(MSMagazineListView *)view {
    return _productsInfo;
}

#pragma mark Download delegate methods

- (void)download:(MSDownload *)download didFinishLoadingWithData:(NSData *)data {
    if (data) {
        NSError *err;
        NSDictionary *d = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        if (!err) {
            _productsInfo = [d objectForKey:@"issues"];
            _products = [NSMutableDictionary dictionary];
            _pricedProductCount = 0;
            _pricedProductCountFinished = 0;
            for (NSDictionary *s in _productsInfo) {
                if ([[s objectForKey:@"price"] floatValue] > 0) {
                    _pricedProductCount++;
                    if (![_products objectForKey:[s objectForKey:@"identifier"]]) {
                        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:[s objectForKey:@"identifier"]]];
                        [request setDelegate:self];
                        [request start];
                    }
                }
            }
        }
    }
}

- (void)download:(MSDownload *)download didFinishLoadingWithError:(NSError *)error {
    
}

- (void)download:(MSDownload *)download didUpdatePercentageProgressStatus:(CGFloat)percentage {
    if ([_delegate respondsToSelector:@selector(magazineView:didUpdatePercentageValue:)]) {
        [_delegate magazineView:self didUpdatePercentageValue:percentage];
    }
}


@end
