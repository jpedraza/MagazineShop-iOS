//
//  MSDataHolder.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 30/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSDataHolder.h"
#import "MSProduct.h"


@implementation MSDataHolder


#pragma mark Initialization

+ (MSDataHolder *)sharedObject {
    static MSDataHolder *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MSDataHolder alloc] init];
    });
    return sharedInstance;
}

#pragma mark Products

- (MSProduct *)productAtIndex:(NSInteger)index {
    return [_products objectAtIndex:index];
}


@end
