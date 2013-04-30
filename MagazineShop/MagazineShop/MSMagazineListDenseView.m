//
//  MSMagazineListDenseView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazineListDenseView.h"
#import "MSMagezineDenseCell.h"
#import "MSMagazineView.h"


@implementation MSMagazineListDenseView


#pragma mark Configuration

- (UICollectionViewFlowLayout *)flowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setItemSize:CGSizeMake(180, 240)];
    [flowLayout setMinimumInteritemSpacing:20];
    return flowLayout;
}

- (NSString *)cellIdentifier {
    return @"MSMagezineDenseCell";
}

- (void)registerCell {
    [super.collectionView registerClass:[MSMagezineDenseCell class] forCellWithReuseIdentifier:[self cellIdentifier]];
}

#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
}

#pragma mark Initialization

- (void)configureView {
    [super configureView];
}

#pragma mark Collection view data source methods

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (self.width > self.height) return UIEdgeInsetsMake(50, 20, 50, 20);
    else return UIEdgeInsetsMake(50, 50, 50, 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.width > self.height) return 20;
    else return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSMagezineDenseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    MSProduct *issueData = [[MSDataHolder sharedObject] productAtIndex:indexPath.row];
    [cell setIssueData:issueData];
    [cell setDelegate:(MSMagazineView *)self.superview];
    [issueData setAssignedCell:cell];
    return cell;
}


@end
