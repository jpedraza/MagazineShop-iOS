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

@property (nonatomic, strong) UIScrollView *secretScrollView;

@end


@implementation MSMagazineListSingleView


#pragma mark Configuration

- (UICollectionViewFlowLayout *)flowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:50];
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
    _secretScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [_secretScrollView setAutoresizingWidthAndHeight];
    [_secretScrollView setDelegate:self];
    [_secretScrollView setPagingEnabled:YES];
    [self addSubview:_secretScrollView];
}

- (void)createAllElements {
    [super createAllElements];
    [self createSecretScrollView];
}

#pragma mark Data

- (void)reloadData {
    [super reloadData];
    
    NSInteger count = [super collectionView:self.collectionView numberOfItemsInSection:0];
    [_secretScrollView setContentSize:CGSizeMake((count * self.width), self.height)];
    [self scrollViewDidScroll:_secretScrollView];
}

#pragma mark Initialization

- (void)configureView {
    [super configureView];
}

#pragma mark Collection view data source methods

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([super isTablet]) {
        if (self.width > self.height) return UIEdgeInsetsMake(50, 50, 50, 50);
        else return UIEdgeInsetsMake(50, 50, 50, 50);
    }
    else return UIEdgeInsetsMake(20, 20, 20, 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([super isTablet]) {
        if (self.width > self.height) return CGSizeMake(700, 525);
        else return CGSizeMake(525, 700);
    }
    else {
        return CGSizeMake(280, 320);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSMagazineSingeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    MSProduct *issueData = [super productAtIndex:indexPath.row];
    [cell setIssueData:issueData];
    return cell;
}

#pragma mark ScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _secretScrollView) {
        BOOL isLandscape = (self.width > self.height);
        CGFloat offset = scrollView.contentOffset.x;
        CGFloat iw = 0;
        CGFloat deduction = 0;
        if ([super isTablet]) {
            deduction = (isLandscape ? 110 : 70);
            iw = isLandscape ? 750.0f : 575.0f;
        }
        else {
            iw = 280;
            deduction = -40;
        }
        CGFloat x = ((((offset * 1) / self.width) * iw) - deduction);
        //NSLog(@"X: %f (%f)", x, offset);
        [self.collectionView setContentOffset:CGPointMake(x, 0)];
    }
}


@end
