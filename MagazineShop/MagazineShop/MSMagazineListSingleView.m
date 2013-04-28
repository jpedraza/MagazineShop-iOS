//
//  MSMagazineListSingleView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineListSingleView.h"
#import "MSMagazineListSingleInvisibleScrollView.h"
#import "MSMagazineSingeCell.h"


@interface MSMagazineListSingleView ()

@property (nonatomic, strong) MSMagazineListSingleInvisibleScrollView *secretScrollView;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) BOOL firstLayoutFinished;

@property (nonatomic, strong) UIView *touchIndicator;

@end


@implementation MSMagazineListSingleView


#pragma mark Positioning

- (CGSize)cardSizeOnTablet {
    if (self.width > self.height) return CGSizeMake(700, 525);
    else return CGSizeMake(525, 700);
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    
    if ([super isTablet]) {
        [self.collectionView setHeight:[self cardSizeOnTablet].height];
        [self.collectionView centerVertically];
    }
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

- (void)createSecretScrollView {
    _secretScrollView = [[MSMagazineListSingleInvisibleScrollView alloc] initWithFrame:self.bounds];
    [_secretScrollView setAutoresizingWidthAndHeight];
    [_secretScrollView setDelegate:self];
    [_secretScrollView setPagingEnabled:YES];
    [self addSubview:_secretScrollView];
}

- (void)createAllElements {
    [super createAllElements];
    if ([super isTablet]) {
        [self createSecretScrollView];
        [self setNeedsLayout];
    }
    else {
        [self.collectionView setPagingEnabled:YES];
    }
}

#pragma mark Data

- (void)reloadData {
    [super reloadData];
    
    NSInteger count = [super collectionView:self.collectionView numberOfItemsInSection:0];
    [_secretScrollView setContentSize:CGSizeMake((count * self.width), self.height)];
}

#pragma mark Initialization

- (void)configureView {
    [super configureView];
}

#pragma mark Settings

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self reloadData];
    
    [_secretScrollView setContentOffset:CGPointMake(((_currentPage + 0) * frame.size.width), 0)];
    [self setOffsetForScrollView:_secretScrollView];
    
    [self setNeedsLayout];
}

#pragma mark Collection view data source methods

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([super isTablet]) {
        if (self.width > self.height) return UIEdgeInsetsMake(50, 50, 50, 50);
        else return UIEdgeInsetsMake(50, 50, 50, 50);
    }
    else return UIEdgeInsetsMake(20, 10, 20, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([super isTablet]) {
        return [self cardSizeOnTablet];
    }
    else {
        return CGSizeMake(300, 320);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!_firstLayoutFinished) {
        _firstLayoutFinished = YES;
        [_secretScrollView setContentOffset:CGPointMake((_currentPage * _secretScrollView.width), 0)];
        [self scrollViewDidScroll:_secretScrollView];
    }
    MSMagazineSingeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    MSProduct *issueData = [super productAtIndex:indexPath.row];
    [cell setIssueData:issueData];
    return cell;
}

#pragma mark ScrollView delegate methods

- (void)setOffsetForScrollView:(UIScrollView *)scrollView {
    BOOL isLandscape = (self.width > self.height);
    CGFloat iw = 0;
    CGFloat deduction = 0;
    CGFloat x = 0;
    if ([super isTablet]) {
        deduction = (isLandscape ? 110 : 70);
        iw = isLandscape ? 750.0f : 575.0f;
    }
    else {
        iw = 310;
        deduction = 10;
    }
    x = (((scrollView.contentOffset.x / self.width) * iw) - deduction);
    [self.collectionView setContentOffset:CGPointMake(x, 0)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _secretScrollView) {
        [self setOffsetForScrollView:scrollView];
        _currentPage = (scrollView.contentOffset.x / self.width);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentPage = (scrollView.contentOffset.x / self.width);
    NSLog(@"Current page: %d", _currentPage);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        _currentPage = (scrollView.contentOffset.x / self.width);
        NSLog(@"Current page: %d", _currentPage);
    }
}


@end
