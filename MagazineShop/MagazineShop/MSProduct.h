//
//  MSProduct.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    MSProductAvailabilityNotPresent,
    MSProductAvailabilityPartiallyDownloaded,
    MSProductAvailabilityDownloaded
} MSProductAvailability;


@interface MSProduct : NSObject

@property (nonatomic, strong) SKProduct *product;
@property (nonatomic, strong, readonly) NSDictionary *originalInfoDictionary;

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *info;
@property (nonatomic, strong, readonly) NSString *thumbnail;
@property (nonatomic, strong, readonly) NSString *cover;
@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSDate *date;

- (void)fillDataFromDictionary:(NSDictionary *)data;

- (MSProductAvailability)productAvailability;


@end
