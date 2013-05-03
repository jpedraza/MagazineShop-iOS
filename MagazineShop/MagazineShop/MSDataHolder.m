//
//  MSDataHolder.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 30/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSDataHolder.h"
#import "MSProduct.h"


#define kMSDataHolderProductAvailabilityKey                     @"MSDataHolderProductAvailabilityKey"


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

+ (void)registerAvailability:(MSProductAvailability)availability forProduct:(MSProduct *)product {
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kMSDataHolderProductAvailabilityKey]];
    if (!d) {
        d = [NSMutableDictionary dictionary];
    }
    [d setObject:[NSNumber numberWithInt:availability] forKey:product.identifier];
    [[NSUserDefaults standardUserDefaults] setObject:d forKey:kMSDataHolderProductAvailabilityKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (MSProductAvailability)availabilityForProduct:(MSProduct *)product {
    NSDictionary *d = [[NSUserDefaults standardUserDefaults] objectForKey:kMSDataHolderProductAvailabilityKey];
    if (![d objectForKey:product.identifier]) return MSProductAvailabilityNotPresent;
    return [[d objectForKey:product.identifier] intValue];
}

+ (void)resetProductAvailability {
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionary] forKey:kMSDataHolderProductAvailabilityKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
