//
//  MSMagazineView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 20/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSMagazineView.h"


@interface MSMagazineView ()

@property (nonatomic, strong) MSMagazineCoverFlowView *magazineCoverFlowView;
@property (nonatomic, strong) MSMagazineListSingleView *magazineSingleView;
@property (nonatomic, strong) MSMagazineListMediumView *magazineListView;
@property (nonatomic, strong) MSMagazineListDenseView *magazineDenseView;

@property (nonatomic, strong) MSMagazineListView *currentMagazineView;

@property (nonatomic, strong) NSMutableDictionary *products;
@property (nonatomic, strong) NSArray *productsInfo;
@property (nonatomic) NSInteger pricedProductCount;
@property (nonatomic) NSInteger pricedProductCountFinished;
@property (nonatomic, strong) NSMutableDictionary *productRequests;
@property (nonatomic, strong) NSMutableArray *failedProductRequests;

@property (nonatomic, strong) id <MSMagazineListViewDelegate> magazineDelegate;

@property (nonatomic) BOOL firstStart;
@property (nonatomic) BOOL didLoadPrices;

@property (nonatomic, strong) GCNetworkReachability *reachability;

@end


@implementation MSMagazineView


#pragma mark Creating elements

- (void)createCoverFlowView {
    _magazineCoverFlowView = [[MSMagazineCoverFlowView alloc] initWithFrame:self.bounds];
    [_magazineCoverFlowView setAlpha:0];
    [_magazineCoverFlowView setAutoresizingWidthAndHeight];
    [_magazineCoverFlowView setDataSource:self];
    [_magazineCoverFlowView setDelegate:_magazineDelegate];
    [self addSubview:_magazineCoverFlowView];
    _currentMagazineView = _magazineCoverFlowView;
}

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

#pragma mark Initialization

- (void)configureView {
    _reachability = kReachability;
    [_reachability startMonitoringNetworkReachabilityWithHandler:^(GCNetworkReachabilityStatus status) {
        if (status != GCNetworkReachabilityStatusNotReachable) {
            [self loadFailedProducts];
        }
    }];
}

#pragma mark Settings

- (void)setMagazineDelegate:(id<MSMagazineListViewDelegate>)delegate {
    _magazineDelegate = delegate;
    [_magazineListView setDelegate:_magazineDelegate];
}

- (void)removeAllViews {
    [_magazineCoverFlowView removeFromSuperview];
    _magazineCoverFlowView = nil;
    
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

- (void)showMagazineCoverFlowView {
    [self removeAllViews];
    [self createCoverFlowView];
    [self animateNewMagazineViewOn];
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
            if (kShopUseCoverflow) selector = @selector(showMagazineCoverFlowView);
            else selector = @selector(showMagazineSingleView);
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
    else {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [_currentMagazineView.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft | UICollectionViewScrollPositionTop animated:YES];
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
    MSDownload *download = [[MSDownload alloc] initWithURL:url withDelegate:self andCacheLifetime:MSDownloadCacheLifetimeForever];
    [kDownloadOperation addOperation:download];
}

- (void)loadFailedProducts {
    @synchronized(self) {
        NSArray *failed = [NSArray arrayWithArray:_failedProductRequests];
        for (NSString *identifier in failed) {
            SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:identifier]];
            [request setDelegate:self];
            [_failedProductRequests removeObject:identifier];
            [request start];
        }
    }
}

- (void)startDownloadingProductWithIdentifier:(NSString *)identifier {
    MSProduct *product = [[MSDataHolder sharedObject] productForIdentifier:identifier];
    [product downloadIssueWithDelegate:self];
}

#pragma mark Product cell delegate methods

- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestActionFor:(MSProduct *)product {
    if (![MSInAppPurchase isProductPurchased:product]) {
        if ([kReachability isReachable]) {
            [kMSInAppPurchase buyProduct:product.product];
//            [cell.actionButton setTitle:MSLangGet(@"Buying") forState:UIControlStateNormal];
//            [cell.actionButton setEnabled:NO];
        }
        else {
            NSString *message = MSLangGet(@"Your internet connection appears to be offline.");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:MSLangGet(@"Connection error") message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    else {
        
    }
}

- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestDetailFor:(MSProduct *)product {
    
}

- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestCoverFor:(MSProduct *)product {
    
}

- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestReloadFor:(MSProduct *)product {
    [_currentMagazineView reloadData];
}

#pragma mark Issue download delegate methods

- (void)product:(MSProduct *)product didDownloadItem:(NSInteger)item of:(NSInteger)totalItems {
    NSLog(@"Downloaded item: %d of %d (%@)", item, totalItems, ([product isPageWithIndex:item availableInSize:MSProductPageSizeLarge] ? @"Ok" : @"Fail"));
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
            _didLoadPrices = NO;
            [[MSDataHolder sharedObject] setProducts:[NSMutableArray array]];
            [self setFailedProductRequests:[NSMutableArray array]];
            [self setProductRequests:[NSMutableDictionary dictionary]];
            for (NSDictionary *s in _productsInfo) {
                MSProduct *product = [[MSProduct alloc] init];
                [product fillDataFromDictionary:s];
                MSMagazines *magazine = [MSDataHolder registerMagazineWithInfo:s];
                [product setMagazine:magazine];
                [[MSDataHolder sharedObject].products addObject:product];
                if ([[s objectForKey:@"price"] floatValue] > 0) {
                    _pricedProductCount++;
                    if (![_products objectForKey:product.identifier]) {
                        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:[s objectForKey:@"identifier"]]];
                        [request setDelegate:self];
                        [_productRequests setObject:request forKey:product.identifier];
                        [request start];
                    }
                }
            }
            [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            if ([_delegate respondsToSelector:@selector(magazineViewDidFinishLoadingData:)]) {
                [(NSObject *)_delegate performSelectorOnMainThread:@selector(magazineViewDidFinishLoadingData:) withObject:self waitUntilDone:NO];
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

#pragma mark StoreKit delegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    _pricedProductCountFinished++;
    for (SKProduct *p in response.products) {
        [_products setObject:p forKey:p.productIdentifier];
        MSProduct *product = [[MSDataHolder sharedObject] productForIdentifier:p.productIdentifier];
        if (product) {
            //[MSDataHolder registerAvailability:MSProductAvailabilityNotPresent forProduct:product];
            [product setProduct:[_products objectForKey:p.productIdentifier]];
            [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
        else {
            NSLog(@"Warning: Product with identifier %@ hasn't been created!", product.identifier);
        }
    }
    if (_pricedProductCount == _pricedProductCountFinished) {
        
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSArray *arr = [_productRequests allKeysForObject:request];
    NSString *identifier = [arr lastObject];
    if (identifier) {
        [_failedProductRequests addObject:identifier];
    }
}


@end
