//
//  MSMagazineListMediumView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineListMediumView.h"
#import "MSMagazineMediumCell.h"


@implementation MSMagazineListMediumView


#pragma mark Creating elements

- (UICollectionViewFlowLayout *)flowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setItemSize:CGSizeMake(200, 200)];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    return flowLayout;
}

- (NSString *)cellIdentifier {
    return @"MSMagazineMediumCell";
}

- (void)registerCell {
    [super.collectionView registerClass:[MSMagazineMediumCell class] forCellWithReuseIdentifier:[self cellIdentifier]];
}

- (void)createAllElements {
    [super createAllElements];
}

#pragma mark Initialization

- (void)configureView {
    [super configureView];
}

#pragma mark Collection view data source methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSMagazineMediumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    
    return cell;
}


@end
