//
//  MSMagazineListSingleView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineListSingleView.h"
#import "MSMagazineSingeCell.h"
#import "MSMagazineView.h"


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
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
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
    [cell setDelegate:(MSMagazineView *)self.superview];
    return cell;
}

#pragma mark ScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _currentPage = (scrollView.contentOffset.x / [self cardSize].width);
}

- (NSArray *)visibleCellViews {
    NSMutableArray *orderedCells = self.collectionView.visibleCells.mutableCopy;
    [orderedCells sortUsingComparator:^NSComparisonResult(UIView *v1, UIView *v2) {
        return [@(v1.xOrigin) compare:@(v2.xOrigin)];
    }];
    return orderedCells;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat horizontalVelocity = fabs(velocity.x);
	CGFloat currentXOffset = scrollView.contentOffset.x;
	CGPoint middlePoint = CGPointMake(CGRectGetMidX(scrollView.bounds), CGRectGetMidY(scrollView.bounds));
	
	UIView *currentView = nil;
	NSArray *visibleCellViews = self.visibleCellViews;
	
	for (UIView *v in visibleCellViews) {
		if (CGRectContainsPoint(v.frame, middlePoint)) {
			currentView = v;
			break;
		}
	}
	
	CGFloat convertedCenterOffsetX = [self convertPoint:currentView.center fromView:scrollView].x;
	CGFloat midWidth = self.bounds.size.width / 2.0;
	
	CGFloat finalXOffset = 0.0;
	if (targetContentOffset->x < currentXOffset) {
		// Going left
		if (horizontalVelocity > 0.15 && convertedCenterOffsetX > midWidth) {
            if (currentView) {
				NSInteger currentViewIndex = [visibleCellViews indexOfObject:currentView];
                if (currentViewIndex > 0) {
                    UIView *viewBefore = visibleCellViews[currentViewIndex - 1];
                    finalXOffset = viewBefore.center.x - midWidth;
                }
                else {
					finalXOffset = currentView.center.x - midWidth;
				}
            }
		}
        else {
			finalXOffset = currentView.center.x - midWidth;
		}
	}
    else {
		// Going right
		if (horizontalVelocity > 0.15 && convertedCenterOffsetX < midWidth) {
            if (currentView) {
				NSInteger currentViewIndex = [visibleCellViews indexOfObject:currentView];
                if (currentViewIndex < visibleCellViews.count) {
                    UIView *viewAfter = visibleCellViews[currentViewIndex + 1];
                    finalXOffset = viewAfter.center.x - midWidth;
                }
            }
		}
        else {
			finalXOffset = currentView.center.x - midWidth;
		}
	}
	finalXOffset = roundf(finalXOffset);
	if (finalXOffset <= 0) finalXOffset = 0 + FLT_EPSILON;
	if (finalXOffset >= scrollView.contentSize.width - scrollView.bounds.size.width) {
		finalXOffset = scrollView.contentSize.width - scrollView.bounds.size.width - 0.1;
	}
	targetContentOffset->x = finalXOffset;
}


@end
