//
//  MSMagazineReaderData.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSMagazineReaderViewControllerDataProtocol.h"


@class MSMagazinePageViewController;

@interface MSMagazineReaderData : NSObject <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) MSProduct *product;
@property (nonatomic, readonly) NSInteger currentPage;

- (MSMagazinePageViewController *)pageViewControllerWithIndex:(NSInteger)index;


@end
