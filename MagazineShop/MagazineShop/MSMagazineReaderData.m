//
//  MSMagazineReaderData.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazineReaderData.h"
#import "MSMagazinePageViewController.h"


@interface MSMagazineReaderData ()

@end


@implementation MSMagazineReaderData


#pragma mark Data



#pragma mark Serving controllers

- (MSMagazinePageViewController *)pageViewControllerWithIndex:(NSInteger)index {
    if (index < 0 || index >= _product.pages) return nil;
    MSMagazinePageViewController *c = [[MSMagazinePageViewController alloc] init];
    [c setProduct:_product];
    [c setPageIndex:index];
    return c;
}

- (NSInteger)indexOfController:(MSMagazinePageViewController *)controller {
    return controller.pageIndex;
}

#pragma mark Settings

- (void)setProduct:(MSProduct *)product {
    _product = product;
    _currentPage = [_product currentPage];
}

#pragma mark Initialization

- (id)init {
    self = [super init];
    if (self) {
        _currentPage =  0;
    }
    return self;
}

#pragma mark Page view controller delegate & data source

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return _product.pages;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return [self pageViewControllerWithIndex:([self indexOfController:(MSMagazinePageViewController *)viewController] + 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return [self pageViewControllerWithIndex:([self indexOfController:(MSMagazinePageViewController *)viewController] - 1)];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    
}


@end
