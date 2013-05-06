//
//  MSDownload.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    MSDownloadCacheLifetimeNone,
    MSDownloadCacheLifetimeForever,
    MSDownloadCacheLifetimeSession,
    MSDownloadCacheLifetimeTerminate
} MSDownloadCacheLifetime;


@class MSDownload;

@protocol MSDownloadDelegate <NSObject>


- (void)download:(MSDownload *)download didFinishLoadingWithData:(NSData *)data;

@optional
- (void)download:(MSDownload *)download didFinishLoadingWithError:(NSError *)error;
- (void)download:(MSDownload *)download didUpdatePercentageProgressStatus:(CGFloat)percentage;

@end


@interface MSDownload : NSOperation <NSURLConnectionDelegate>

@property (nonatomic, strong) NSString *connectionURL;
@property (nonatomic, strong) NSDictionary *postParameters;

@property (nonatomic) BOOL executing;
@property (nonatomic) BOOL finished;

@property (nonatomic, strong) NSString *specialCacheFolder;
@property (nonatomic, strong) NSString *specialCacheFile;
@property (nonatomic, strong, readonly) NSString *cacheFilePath;

@property (nonatomic, readonly) MSDownloadCacheLifetime cacheLifetime;
@property (nonatomic, strong, readonly) NSURLConnection *connection;

@property (nonatomic, weak, readonly) id <NSURLConnectionDelegate, NSURLConnectionDataDelegate> connectionDelegate;
@property (nonatomic, weak, readonly) id <MSDownloadDelegate> delegate;

- (id)initWithURL:(NSString *)urlPath withDelegate:(id <MSDownloadDelegate>)delegate andCacheLifetime:(MSDownloadCacheLifetime)lifetime;
- (id)initWithURL:(NSString *)urlPath withPostParameters:(NSMutableDictionary *)postParameters withDelegate:(id <MSDownloadDelegate>)delegate andCacheLifetime:(MSDownloadCacheLifetime)lifetime;
- (id)initWithURL:(NSString *)urlPath withPostParameters:(NSMutableDictionary *)postParameters andUrlConnectionDelegate:(id <NSURLConnectionDelegate, NSURLConnectionDataDelegate>)delegate;

- (BOOL)isConcurrent;
- (BOOL)isExecuting;
- (BOOL)isFinished;

- (void)cancel;

+ (NSString *)folderPath:(MSDownloadCacheLifetime)cacheLifetime withSpecialCacheFolder:(NSString *)specialCacheFolder;
+ (NSString *)filePath:(MSDownloadCacheLifetime)cacheLifetime withSpecialCacheFolder:(NSString *)specialCacheFolder andFile:(NSString *)specialCacheFile;
+ (void)clearCache:(MSDownloadCacheLifetime)cacheLifetime;
+ (NSString *)safeText:(NSString *)text;

+ (BOOL)isFileForUrlString:(NSString *)urlPath andCacheLifetime:(MSDownloadCacheLifetime)cacheLifetime;
+ (NSString *)fileForUrlString:(NSString *)urlPath andCacheLifetime:(MSDownloadCacheLifetime)cacheLifetime;


@end
