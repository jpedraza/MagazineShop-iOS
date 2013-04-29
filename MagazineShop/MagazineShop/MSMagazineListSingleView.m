//
//  MSMagazineListSingleView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineListSingleView.h"
#import "MSMagazineSingeCell.h"


@interface MSMagazineListSingleView ()

@property (nonatomic) NSInteger currentPage;
@property (nonatomic) BOOL firstLayoutFinished;

@end


@implementation MSMagazineListSingleView


#pragma mark Positioning

- (CGSize)cardSize {
    if ([super isTablet]) {
        if (self.width > self.height) return CGSizeMake(700, 525);
        else return CGSizeMake(525, 700);
    }
    else {
        return CGSizeMake(300, 320);
    }
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
}

- (void)scrollCollectionViewToPage:(NSInteger)page {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:page inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark Configuration

- (UICollectionViewFlowLayout *)flowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:([super isTablet] ? 50 : 50)];
    [flowLayout setMinimumLineSpacing:50];
    return flowLayout;
}

- (NSString *)cellIdentifier {
    return @"MSMagazineSingeCell";
}

- (void)registerCell {
    [super.collectionView registerClass:[MSMagazineSingeCell class] forCellWithReuseIdentifier:[self cellIdentifier]];
}

#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
}

#pragma mark Data

- (void)reloadData {
    [super reloadData];
    
    [self.collectionView setHeight:[self cardSize].height];
    [self.collectionView centerVertically];
}

#pragma mark Initialization

- (void)configureView {
    [super configureView];
}

#pragma mark Settings

- (void)setFrame:(CGRect)frame {
    NSInteger page = _currentPage;
    [super setFrame:frame];
    [self reloadData];
    [self scrollCollectionViewToPage:page];
}

#pragma mark Collection view data source methods

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([super isTablet]) {
        if (self.width > self.height) return UIEdgeInsetsMake(50, 50, 50, 50);
        else return UIEdgeInsetsMake(50, 50, 50, 50);
    }
    else return UIEdgeInsetsMake(20, 10, 20, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self cardSize];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSMagazineSingeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    MSProduct *issueData = [super productAtIndex:indexPath.row];
    [cell setIssueData:issueData];
    return cell;
}

#pragma mark ScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _currentPage = (scrollView.contentOffset.x / [self cardSize].width);
    NSLog(@"Current page: %d", _currentPage);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollCollectionViewToPage:_currentPage];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    CGFloat verticalVelocity = fabs(velocity.y);
//    
//    CGFloat currentYOffset = scrollView.contentOffset.y;
//    
//    CGFloat currentPageOffset = roundf(currentYOffset / _relaxedItemHeight) * _relaxedItemHeight;
//    
//    CGFloat finalYOffset = 0.0;
//    if (targetContentOffset->y < currentYOffset) {
//        //going upward
//        if (targetContentOffset->y == self.contentSize.height - self.bounds.size.height) {
//            finalYOffset = targetContentOffset->y;
//        } else if (verticalVelocity > 0.15) {
//            finalYOffset = currentPageOffset - _relaxedItemHeight;
//        } else {
//            finalYOffset = currentPageOffset;
//        }
//    } else {
//        //going downward
//        if (targetContentOffset->y == 0) {
//            finalYOffset = targetContentOffset->y;
//        } else if (verticalVelocity > 0.15) {
//            finalYOffset = currentPageOffset + _relaxedItemHeight;
//        } else {
//            finalYOffset = currentPageOffset;
//        }
//    }
//    if (finalYOffset < 0) finalYOffset = 0;
//    if (finalYOffset > scrollView.contentSize.height - scrollView.bounds.size.height) finalYOffset = scrollView.contentSize.height - scrollView.bounds.size.height;
//    targetContentOffset->y = finalYOffset;
}


@end
