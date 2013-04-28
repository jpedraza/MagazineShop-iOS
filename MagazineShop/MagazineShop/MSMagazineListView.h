//
//  MSMagazineListView.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSView.h"
#import "MSProduct.h"


typedef enum {
    MSMagazineListViewVisibilityStatusVisible,
    MSMagazineListViewVisibilityStatusHidden
} MSMagazineListViewVisibilityStatus;


@class MSMagazineListView;

@protocol MSMagazineListViewDataSource <NSObject>

- (NSDictionary *)magazineListViewProductsForCollectionView:(MSMagazineListView *)view;
- (NSArray *)magazineListViewProductsInfoForCollectionView:(MSMagazineListView *)view;

@end


@protocol MSMagazineListViewDelegate <NSObject>

- (void)magazineListView:(MSMagazineListView *)magazineView changedVisibilityStatus:(MSMagazineListViewVisibilityStatus)status;

@end


@interface MSMagazineListView : MSView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) id <MSMagazineListViewDataSource> dataSource;
@property (nonatomic, weak) id <MSMagazineListViewDelegate> delegate;

- (UICollectionViewFlowLayout *)flowLayout;
- (NSString *)cellIdentifier;
- (void)registerCell;

- (void)show;
- (void)hide;

- (NSDictionary *)products;
- (NSArray *)productsInfo;
- (MSProduct *)productAtIndex:(NSInteger)index;
- (void)buyProduct:(SKProduct *)product;

- (void)reloadData;


@end
