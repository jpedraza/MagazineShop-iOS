//
//  MSMagazineListView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineListView.h"


@implementation MSMagazineListView


#pragma mark Creating elements

- (UICollectionViewFlowLayout *)flowLayout {
    return nil;
}

- (NSString *)cellIdentifier {
    return nil;
}

- (void)registerCell {
    
}

- (void)createCollectionView {
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self flowLayout]];
    [_collectionView setAutoresizingWidthAndHeight];
    [_collectionView setBackgroundColor:[UIColor yellowColor]];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBounces:YES];
    [self registerCell];
    [self addSubview:_collectionView];
}

- (void)createAllElements {
    [super createAllElements];
    [self createCollectionView];
}

#pragma mark Settings

- (void)show {
    
}

- (void)hide {
    
}

#pragma mark StoreKit methods

- (void)buyProduct:(SKProduct *)product {
    
}

#pragma mark Data

- (void)reloadData {
    [_collectionView reloadData];
}

- (NSDictionary *)products {
    if ([_dataSource respondsToSelector:@selector(magazineListViewProductsForCollectionView:)]) {
        return [_dataSource magazineListViewProductsForCollectionView:self];
    }
    else return [NSDictionary dictionary];
}

- (NSArray *)productsInfo {
    if ([_dataSource respondsToSelector:@selector(magazineListViewProductsInfoForCollectionView:)]) {
        return [_dataSource magazineListViewProductsInfoForCollectionView:self];
    }
    else return [NSArray array];
}

#pragma mark Collection view datasource & delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self productsInfo] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
