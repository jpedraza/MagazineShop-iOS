//
//  MSDownload.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MSDownload;

@protocol MSDownloadDelegate <NSObject>

- (void)download:(MSDownload *)download didFinishLoadingWithData:(NSData *)data;
- (void)download:(MSDownload *)download didFinishLoadingWithError:(NSError *)error;
- (void)download:(MSDownload *)download didUpdatePercentageProgressStatus:(NSInteger)percentage;

@end


@interface MSDownload : NSOperation <NSURLConnectionDelegate>

@property (nonatomic, strong) NSString *connectionURL;
@property (nonatomic, strong) NSDictionary *postParameters;

@property (nonatomic) BOOL executing;
@property (nonatomic) BOOL finished;

@property (nonatomic, strong, readonly) NSURLConnection *connection;

@property (nonatomic, weak, readonly) id <NSURLConnectionDelegate, NSURLConnectionDataDelegate> connectionDelegate;
@property (nonatomic, weak, readonly) id <MSDownloadDelegate> delegate;

- (id)initWithURL:(NSString *)urlPath andDelegate:(id <MSDownloadDelegate>)delegate;
- (id)initWithURL:(NSString *)urlPath withPostParameters:(NSMutableDictionary *)postParameters andDelegate:(id <MSDownloadDelegate>)delegate;
- (id)initWithURL:(NSString *)urlPath withPostParameters:(NSMutableDictionary *)postParameters andUrlConnectionDelegate:(id <NSURLConnectionDelegate, NSURLConnectionDataDelegate>)delegate;

- (BOOL)isConcurrent;
- (BOOL)isExecuting;
- (BOOL)isFinished;

- (void)cancel;


@end
