//
//  MSProduct.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSProduct.h"
#import "MSMagazineBasicCell.h"
#import "MBProgressHUD.h"


@interface MSProduct ()

@property (nonatomic, strong) NSMutableArray *downloadObjectsArray;
//@property (nonatomic) MSProductAvailability availability;
@property (nonatomic) NSInteger pagesDownloaded;
@property (nonatomic) NSInteger pagesProcessed;
@property (nonatomic) NSInteger totalDownloads;

@property (nonatomic, strong) MSDownload *thumbnailDownload;
@property (nonatomic, strong) MSDownload *coverDownload;
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) UIImage *coverImage;

@end


@implementation MSProduct


#pragma mark Settings

- (void)fillDataFromDictionary:(NSDictionary *)data {
    _originalInfoDictionary = data;
    _name = [data objectForKey:@"name"];
    _info = [data objectForKey:@"info"];
    _thumbnail = [data objectForKey:@"thumbnail"];
    _cover = [data objectForKey:@"cover"];
    _identifier = [data objectForKey:@"identifier"];
    _date = [NSDate dateWithTimeIntervalSince1970:[[data objectForKey:@"date"] integerValue]];
    _base = [data objectForKey:@"base"];
    _pages = [[data objectForKey:@"pages"] integerValue];
    _isFree = ([[data objectForKey:@"price"] floatValue] > 0) ? NO : YES;
}

#pragma mark Info

- (NSString *)description {
    return [NSString stringWithFormat:@"Product %@ (%@)", _identifier, _originalInfoDictionary];
}

#pragma mark Issue management

- (NSString *)textualRepresentationOfSize:(MSProductPageSize)size {
    switch (size) {
        case MSProductPageSizeSmall:
            return @"180";
            break;
        case MSProductPageSizeMedium:
            return @"400";
            break;
        case MSProductPageSizeLarge:
            return @"1024";
            break;
        case MSProductPageSizeSuperLarge:
            return @"2048";
            break;
    }
    return @"1024";
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [[NSUserDefaults standardUserDefaults] setInteger:currentPage forKey:[NSString stringWithFormat:@"current-page-%@", _identifier]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)currentPage {
    return [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"current-page-%@", _identifier]];
}

- (BOOL)isPageWithIndex:(NSInteger)index availableInSize:(MSProductPageSize)size {
    NSString *path = [self pathForFileWithIndex:index andSize:size];
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    return exists;
}

- (UIImage *)pageWithIndex:(NSInteger)index inSize:(MSProductPageSize)size {
    NSString *path = [self pathForFileWithIndex:index andSize:size];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) return nil;
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

#pragma mark Environment

- (BOOL)isTablet {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

- (BOOL)isRetina {
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0));
}

- (void)downloadSize:(MSProductPageSize)size withI:(int)i {
    NSString *sizeString = [self textualRepresentationOfSize:size];
    NSString *url = [_base stringByAppendingPathComponent:[NSString stringWithFormat:@"page_%@-%d.jpg", sizeString, i]];
    MSDownload *d = [[MSDownload alloc] initWithURL:url withDelegate:self andCacheLifetime:MSDownloadCacheLifetimeForever];
    [d setSpecialCacheFolder:_identifier];
    [d setSpecialCacheFile:[NSString stringWithFormat:@"%@-%d.jpg", sizeString, i]];
    _totalDownloads++;
    [_downloadObjectsArray addObject:d];
    [kDownloadOperation addOperation:d];
}

- (void)downloadIssueWithDelegate:(id<MSProductDelegate>)delegate {
    _delegate = delegate;
    _downloadObjectsArray = [NSMutableArray array];
    _pagesDownloaded = 0;
    _pagesProcessed = 0;
    _totalDownloads = 0;
    
    _downloadStatus = MSProductDownloadStatusIsDownloading;
    
    for (int i = 0; i < _pages; i++) {
        [self downloadSize:MSProductPageSizeSmall withI:i];
        if (![self isRetina] || ![self isTablet]) {
            [self downloadSize:MSProductPageSizeLarge withI:i];
        }
        else {
            [self downloadSize:MSProductPageSizeSuperLarge withI:i];
        }
    }
}

- (NSString *)pathForFileWithIndex:(NSInteger)index andSize:(MSProductPageSize)size {
    NSString *sizeString = [self textualRepresentationOfSize:size];
    NSString *path = [MSDownload filePath:MSDownloadCacheLifetimeForever withSpecialCacheFolder:_identifier andFile:[NSString stringWithFormat:@"%@-%d.jpg", sizeString, index]];
    return path;
}

- (void)setAssignedCell:(MSMagazineBasicCell *)assignedCell {
    _assignedCell = assignedCell;
}

- (void)downloadCoverImage {
    _thumbnailDownload = [[MSDownload alloc] initWithURL:_cover withDelegate:self andCacheLifetime:MSDownloadCacheLifetimeForever];
    [_thumbnailDownload setQueuePriority:NSOperationQueuePriorityVeryHigh];
    [kDownloadOperation addOperation:_thumbnailDownload];
    
    _coverDownload = [[MSDownload alloc] initWithURL:_cover withDelegate:self andCacheLifetime:MSDownloadCacheLifetimeForever];
    [_thumbnailDownload setQueuePriority:NSOperationQueuePriorityHigh];
    [kDownloadOperation addOperation:_coverDownload];
}

#pragma mark Download delegate methods

- (void)download:(MSDownload *)download didFinishLoadingWithData:(NSData *)data {
    if (download == _thumbnailDownload) {
        
    }
    else if (download == _coverDownload) {
        
    }
    else {
        _pagesDownloaded++;
        _pagesProcessed++;
        if ([_delegate respondsToSelector:@selector(product:didDownloadItem:of:)]) {
            [_delegate product:self didDownloadItem:_pagesProcessed of:_totalDownloads];
        }
        if (_downloadStatus == MSProductDownloadStatusIsDownloading) {
            CGFloat progress = ((((float)_pagesProcessed * 100.0f) / (float)_totalDownloads) / 100.0f);
            if ([_assignedCell respondsToSelector:@selector(progressView)]) {
                [_assignedCell.progressView setProgress:progress];
                [_assignedCell showDownloadingIndicator:YES];
            }
        }
        [_downloadObjectsArray removeObject:download];
        if (_pagesDownloaded == (kMSConfigMinPagesForRead * 2)) {
            
        }
        if (_totalDownloads == _pagesDownloaded) {
            _downloadStatus = MSProductDownloadStatusIdle;
            if ([_assignedCell respondsToSelector:@selector(progressView)]) {
                [_assignedCell showDownloadingIndicator:NO];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"full-%@", self.identifier]];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    }
}

- (void)download:(MSDownload *)download didFinishLoadingWithError:(NSError *)error {
    if (download == _thumbnailDownload) {
        
    }
    else if (download == _coverDownload) {
        
    }
    else {
        NSLog(@"Failed loading: %@ with error: %@", download.connectionURL, [error localizedDescription]);
        [_downloadObjectsArray removeObject:download];
        _pagesProcessed++;
    }
}


@end
