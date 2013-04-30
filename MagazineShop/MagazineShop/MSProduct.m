//
//  MSProduct.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSProduct.h"


@interface MSProduct ()

@property (nonatomic, strong) NSMutableArray *downloadObjectsArray;

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
}

#pragma mark Issue management

- (MSProductAvailability)productAvailability {
    return MSProductAvailabilityNotPresent;
}

- (void)downloadIssueWithDelegate:(id<MSProductDelegate>)delegate {
    if ([self productAvailability] == MSProductAvailabilityDownloaded) return;
    _delegate = delegate;
    _downloadObjectsArray = [NSMutableArray array];
    
    for (int i = 0; i < _pages; i++) {
        NSString *url;
        MSDownload *d;
        
        if (NO) {
            url = [_base stringByAppendingPathComponent:[NSString stringWithFormat:@"page_180-%d.jpg", i]];
            d = [[MSDownload alloc] initWithURL:url withDelegate:self andCacheLifetime:MSDownloadCacheLifetimeForever];
            [d setSpecialCacheFolder:_identifier];
            [_downloadObjectsArray addObject:d];
            [kDownloadOperation addOperation:d];
            
            url = [_base stringByAppendingPathComponent:[NSString stringWithFormat:@"page_400-%d.jpg", i]];
            d = [[MSDownload alloc] initWithURL:url withDelegate:self andCacheLifetime:MSDownloadCacheLifetimeForever];
            [d setSpecialCacheFolder:_identifier];
            [_downloadObjectsArray addObject:d];
            [kDownloadOperation addOperation:d];
        }
        
        url = [_base stringByAppendingPathComponent:[NSString stringWithFormat:@"page_1024-%d.jpg", i]];
        d = [[MSDownload alloc] initWithURL:url withDelegate:self andCacheLifetime:MSDownloadCacheLifetimeForever];
        [d setSpecialCacheFolder:_identifier];
        [_downloadObjectsArray addObject:d];
        [kDownloadOperation addOperation:d];
        
        url = [_base stringByAppendingPathComponent:[NSString stringWithFormat:@"page_2048-%d.jpg", i]];
        d = [[MSDownload alloc] initWithURL:url withDelegate:self andCacheLifetime:MSDownloadCacheLifetimeForever];
        [d setSpecialCacheFolder:_identifier];
        [_downloadObjectsArray addObject:d];
        [kDownloadOperation addOperation:d];
    }
}

#pragma mark Download delegate methods

- (void)download:(MSDownload *)download didFinishLoadingWithData:(NSData *)data {
    NSLog(@"Finished loading: %@", download.connectionURL);
    [_downloadObjectsArray removeObject:download];
}

- (void)download:(MSDownload *)download didFinishLoadingWithError:(NSError *)error {
    NSLog(@"Failed loading: %@ with error: %@", download.connectionURL, [error localizedDescription]);
    [_downloadObjectsArray removeObject:download];
}


@end
