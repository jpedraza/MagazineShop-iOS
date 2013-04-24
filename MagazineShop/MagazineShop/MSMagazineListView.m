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
    CGRect r = self.bounds;
    _collectionView = [[UICollectionView alloc] initWithFrame:r collectionViewLayout:[self flowLayout]];
    [_collectionView setAutoresizingWidthAndHeight];
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
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha:1];
    } completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(magazineListView:changedVisibilityStatus:)]) {
            [_delegate magazineListView:self changedVisibilityStatus:MSMagazineListViewVisibilityStatusVisible];
        }
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(magazineListView:changedVisibilityStatus:)]) {
            [_delegate magazineListView:self changedVisibilityStatus:MSMagazineListViewVisibilityStatusHidden];
        }
    }];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [_collectionView reloadData];
}

#pragma mark StoreKit methods

- (void)buyProduct:(SKProduct *)product {
    
}

#pragma mark Data

- (void)reloadData {
    [_collectionView setDataSource:self];
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
    return 50;
    //return [[self productsInfo] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


@end
