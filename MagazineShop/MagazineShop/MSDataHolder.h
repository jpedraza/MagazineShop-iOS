//
//  MSDataHolder.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 30/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MSProduct;

@interface MSDataHolder : NSObject

@property (nonatomic, strong) NSMutableArray *products;

+ (MSDataHolder *)sharedObject;

- (MSProduct *)productAtIndex:(NSInteger)index;

+ (void)registerAvailability:(MSProductAvailability)availability forProduct:(MSProduct *)product;
+ (MSProductAvailability)availabilityForProduct:(MSProduct *)product;
+ (void)resetProductAvailability;


@end
