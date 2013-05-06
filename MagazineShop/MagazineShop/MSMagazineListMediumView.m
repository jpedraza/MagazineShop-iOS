//
//  MSMagazineListMediumView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSMagazineListMediumView.h"
#import "MSMagazineMediumCell.h"
#import "MSMagazineView.h"


@implementation MSMagazineListMediumView


#pragma mark Configuration

- (UICollectionViewFlowLayout *)flowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    if ([super isTablet]) {
        [flowLayout setItemSize:CGSizeMake(300, 300)];
        [flowLayout setMinimumInteritemSpacing:20];
        [flowLayout setMinimumLineSpacing:40];
    }
    else {
        [flowLayout setItemSize:CGSizeMake(140, 200)];
        [flowLayout setMinimumInteritemSpacing:0];
        [flowLayout setMinimumLineSpacing:20];
    }
    return flowLayout;
}

- (NSString *)cellIdentifier {
    return @"MSMagazineMediumCell";
}

- (void)registerCell {
    [super.collectionView registerClass:[MSMagazineMediumCell class] forCellWithReuseIdentifier:[self cellIdentifier]];
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
    if ([super isTablet]) {
        if (self.width > self.height) return UIEdgeInsetsMake(50, 20, 50, 20);
        else return UIEdgeInsetsMake(50, 50, 50, 50);
    }
    else {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSMagazineMediumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    MSProduct *issueData = [[MSDataHolder sharedObject] productAtIndex:indexPath.row];
    [cell setIssueData:issueData];
    [cell setDelegate:(MSMagazineView *)self.superview];
    [issueData setAssignedCell:cell];
    [issueData downloadCoverImage];
    return cell;
}


@end
