//
//  MSProduct.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSDownload.h"


//typedef enum {
//    MSProductAvailabilityNotPresent,
//    MSProductAvailabilityPartiallyDownloaded,
//    MSProductAvailabilityDownloaded,
////    MSProductAvailabilityInQueue,
////    MSProductAvailabilityUpdating
//} MSProductAvailability;
//
typedef enum {
    MSProductDownloadStatusIdle,
    MSProductDownloadStatusIsDownloading
} MSProductDownloadStatus;

typedef enum {
    MSProductPageSizeSmall,
    MSProductPageSizeMedium,
    MSProductPageSizeLarge,
    MSProductPageSizeSuperLarge
} MSProductPageSize;


@class MSProduct, MSMagazineBasicCell, MSMagazineReaderViewController;

@protocol MSProductDelegate <NSObject>

- (void)product:(MSProduct *)product didDownloadItem:(NSInteger)item of:(NSInteger)totalItems;

@end


@interface MSProduct : NSObject <MSDownloadDelegate>

@property (nonatomic, strong) SKProduct *product;
@property (nonatomic, strong) MSMagazines *magazine;
@property (nonatomic, strong) NSArray *magazinePages;
@property (nonatomic, strong, readonly) NSDictionary *originalInfoDictionary;

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *info;
@property (nonatomic, strong, readonly) NSString *thumbnail;
@property (nonatomic, strong, readonly) NSString *cover;
@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSDate *date;
@property (nonatomic, strong, readonly) NSString *base;
@property (nonatomic, readonly) NSInteger pages;
@property (nonatomic, readonly) BOOL isFree;
@property (nonatomic, readonly) MSProductDownloadStatus downloadStatus;

@property (nonatomic) NSInteger currentPage;

@property (nonatomic, weak, readonly) id <MSProductDelegate> delegate;

@property (nonatomic, weak) MSMagazineBasicCell *assignedCell;
@property (nonatomic, weak) MSMagazineReaderViewController *assignedReader;

- (void)fillDataFromDictionary:(NSDictionary *)data;

- (void)downloadIssueWithDelegate:(id <MSProductDelegate>)delegate;
- (BOOL)isPageWithIndex:(NSInteger)index availableInSize:(MSProductPageSize)size;
- (UIImage *)pageWithIndex:(NSInteger)index inSize:(MSProductPageSize)size;
- (NSString *)textualRepresentationOfSize:(MSProductPageSize)size;

- (void)downloadThumbnailImage;
- (void)downloadCoverImage;


@end
