//
//  MSMagazineReaderData.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazineReaderData.h"
#import "MSMagazinePageViewController.h"


@implementation MSMagazineReaderData


#pragma mark Data



#pragma mark Serving controllers

- (MSMagazinePageViewController *)pageViewControllerWithIndex:(NSInteger)index {
    MSMagazinePageViewController *c = [[MSMagazinePageViewController alloc] init];
    [c setProduct:_product];
    [c setPageIndex:index];
    return c;
}

#pragma mark Page view controller delegate & data source

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return _product.pages;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return [self pageViewControllerWithIndex:0];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return [self pageViewControllerWithIndex:0];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    
}


@end
