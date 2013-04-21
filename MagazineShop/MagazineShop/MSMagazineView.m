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

@end


@implementation MSMagazineView


#pragma mark Creating elements

- (void)createMagazineSingleView {
    
}

- (void)createMagazineListView {
    _magazineListView = [[MSMagazineListMediumView alloc] initWithFrame:self.bounds];
    [_magazineListView setAutoresizingWidthAndHeight];
    [_magazineListView setDataSource:self];
    [_magazineListView setDelegate:_magazineDelegate];
    [self addSubview:_magazineListView];
    _currentMagazineView = _magazineListView;
}

- (void)createMagazineDenseView {
    
}

- (void)createAllElements {
    [self setBackgroundColor:[UIColor clearColor]];
    
    [super createAllElements];
    [self createMagazineListView];
}

#pragma mark Settings

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)setMagazineDelegate:(id<MSMagazineListViewDelegate>)delegate {
    _magazineDelegate = delegate;
    [_magazineListView setDelegate:_magazineDelegate];
}

- (void)setListViewType:(MSConfigMainMagazineListViewType)listViewType {
    if (_listViewType != listViewType) {
        _listViewType = listViewType;
        
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
