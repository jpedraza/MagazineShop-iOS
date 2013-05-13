//
//  MSMagazineReaderData.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSMagazineReaderViewControllerDataProtocol.h"


@class MSMagazinePageViewController, MSMagazineReaderViewController;

@interface MSMagazineReaderData : NSObject <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) MSProduct *product;
@property (nonatomic, readonly) NSInteger currentPage;

@property (nonatomic, weak) MSMagazineReaderViewController *viewController;

- (MSMagazinePageViewController *)pageViewControllerWithIndex:(NSInteger)index;


@end
