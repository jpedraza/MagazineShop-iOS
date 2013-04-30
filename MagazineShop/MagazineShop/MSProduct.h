//
//  MSProduct.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSDownload.h"


typedef enum {
    MSProductAvailabilityNotPresent,
    MSProductAvailabilityPartiallyDownloaded,
    MSProductAvailabilityDownloaded
} MSProductAvailability;


@class MSProduct;

@protocol MSProductDelegate <NSObject>

- (void)product:(MSProduct *)product didDownloadItem:(NSInteger)item of:(NSInteger)totalItems;

@end


@interface MSProduct : NSObject <MSDownloadDelegate>

@property (nonatomic, strong) SKProduct *product;
@property (nonatomic, strong, readonly) NSDictionary *originalInfoDictionary;

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *info;
@property (nonatomic, strong, readonly) NSString *thumbnail;
@property (nonatomic, strong, readonly) NSString *cover;
@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSDate *date;
@property (nonatomic, strong, readonly) NSString *base;
@property (nonatomic, readonly) NSInteger pages;

@property (nonatomic, weak, readonly) id <MSProductDelegate> delegate;

- (void)fillDataFromDictionary:(NSDictionary *)data;

- (MSProductAvailability)productAvailability;

- (void)downloadIssueWithDelegate:(id <MSProductDelegate>)delegate;


@end
