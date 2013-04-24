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

- (void)loadData {
    @autoreleasepool {
        NSString *url = [kMSConfigBaseUrl stringByAppendingPathComponent:@"api/issues.json"];
        NSError *err;
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url] options:NSDataReadingUncached error:&err];
        if (!err) {
            NSDictionary *d = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
            _productsInfo = [d objectForKey:@"issues"];
            _products = [NSMutableDictionary dictionary];
            _pricedProductCount = 0;
            for (NSDictionary *s in _productsInfo) {
                if ([[s objectForKey:@"price"] floatValue] > 0) {
                    _pricedProductCount++;
                    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:[s objectForKey:@"identifier"]]];
                    [request setDelegate:self];
                    [request start];
                }
            }
        }
    }
}

- (void)startLoadingProducts {
    @autoreleasepool {
        [self performSelectorInBackground:@selector(loadData) withObject:nil];
    }
}

- (void)loadProducts {
    if ([_delegate respondsToSelector:@selector(magazineViewDidStartLoadingData:)]) {
        [_delegate magazineViewDidStartLoadingData:self];
    }
    [NSThread detachNewThreadSelector:@selector(startLoadingProducts) toTarget:self withObject:nil];
}

#pragma mark StoreKit delegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    for (SKProduct *p in response.products) {
        [_products setObject:p forKey:p.productIdentifier];
    }
    if (_pricedProductCount == [[_products allKeys] count]) {
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


@end
