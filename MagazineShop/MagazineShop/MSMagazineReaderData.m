//
//  MSMagazineReaderData.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSMagazineReaderData.h"
#import "MSMagazinePageViewController.h"
#import "MSMagazineReaderViewController.h"


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

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        // In portrait orientation: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        UIViewController *currentViewController = _viewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        [_viewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        _viewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }
    
    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    MSMagazinePageViewController *currentViewController = _viewController.viewControllers[0];
    NSArray *viewControllers = nil;
    
    NSUInteger indexOfCurrentViewController = [self indexOfController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self pageViewController:_viewController viewControllerAfterViewController:currentViewController];
        viewControllers = @[currentViewController, nextViewController];
    }
    else {
        UIViewController *previousViewController = [self pageViewController:_viewController viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    [_viewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    return UIPageViewControllerSpineLocationMid;
}


@end
