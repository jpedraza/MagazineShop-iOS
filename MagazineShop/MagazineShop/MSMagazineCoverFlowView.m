//
//  MSMagazineCoverFlowView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 03/05/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazineCoverFlowView.h"
#import "MSCoverFlowView.h"
#import "MSMagazineView.h"


@interface MSMagazineCoverFlowView ()

@property (nonatomic, strong) iCarousel *carousel;

@end


@implementation MSMagazineCoverFlowView


#pragma mark Data

- (void)reloadData {
    [super reloadData];
    [_carousel reloadData];
}

#pragma mark Creating elements

- (void)createCarouselView {
    _carousel = [[iCarousel alloc] initWithFrame:self.bounds];
    [_carousel setAutoresizingWidthAndHeight];
    [_carousel setType:iCarouselTypeCoverFlow2];
    [_carousel setDataSource:self];
    [_carousel setDelegate:self];
    [self addSubview:_carousel];
}

- (void)createAllElements {
    self.disableCollectionView = YES;
    [super createAllElements];
    [self createCarouselView];
}

#pragma mark iCarousel delegate & datasource methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return [[self productsInfo] count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    MSCoverFlowView *v = (MSCoverFlowView *)view;
    if (!v) {
        v = [[MSCoverFlowView alloc] initWithFrame:CGRectMake(0, 0, 300, 450)];
    }
    MSProduct *issueData = [[MSDataHolder sharedObject] productAtIndex:index];
    [v setIssueData:issueData];
    [v setDelegate:(MSMagazineView *)self.superview];
    [issueData setAssignedCell:v];
    return v;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    return nil;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    
}

@end
