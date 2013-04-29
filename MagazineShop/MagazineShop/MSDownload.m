//
//  MSDownload.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSDownload.h"


@interface MSDownload ()

@property (nonatomic, strong) NSString *safeUrlString;
@property (nonatomic, strong) NSString *cacheFilePath;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic) NSInteger repeatedConnectionCounter;
@property (nonatomic) long long totalDataSize;

@end


@implementation MSDownload


#pragma mark Caching

+ (NSString *)folderPath:(MSDownloadCacheLifetime)cacheLifetime {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"download-cache-%d", cacheLifetime]];
}

+ (void)clearCache:(MSDownloadCacheLifetime)cacheLifetime {
    // TODO: Clear only when connected to the internet!
    NSString *folderPath = [self folderPath:cacheLifetime];
    BOOL isDir;
    BOOL isFile = [[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:&isDir];
    if (isFile) {
        NSError *err;
        [[NSFileManager defaultManager] removeItemAtPath:folderPath error:&err];
        if (err) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:MSLangGet(@"Error") message:[err localizedDescription] delegate:nil cancelButtonTitle:MSLangGet(@"Ok") otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (NSString *)safeText:(NSString *)text {
	NSString *newText = @"";
	NSString *a;
	for(int i = 0; i < [text length]; i++) {
		a = [text substringWithRange:NSMakeRange(i, 1)];
        NSCharacterSet *unwantedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
		if ([a rangeOfCharacterFromSet:unwantedCharacters].location != NSNotFound) a = @"-";
        newText = [NSString stringWithFormat:@"%@%@", newText, a];
	}
	return newText;
}

- (NSString *)cacheFilePathConstruct {
    NSString *folderPath = [MSDownload folderPath:_cacheLifetime];
    BOOL isDir;
    BOOL isFile = [[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:&isDir];
    if (!isFile || !isDir) {
        NSError *err;
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&err];
        if (err) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:MSLangGet(@"Error") message:[err localizedDescription] delegate:nil cancelButtonTitle:MSLangGet(@"Ok") otherButtonTitles:nil];
            [alert show];
            return nil;
        }
    }
    return [folderPath stringByAppendingPathComponent:_safeUrlString];
}

#pragma mark Initialization

- (id)initWithURL:(NSString *)urlPath withDelegate:(id <MSDownloadDelegate>)delegate andCacheLifetime:(MSDownloadCacheLifetime)lifetime {
    self = [super init];
    if (self) {
        _connectionURL = urlPath;
        _safeUrlString = [self safeText:_connectionURL];
        _postParameters = nil;
        _delegate = delegate;
        _cacheLifetime = lifetime;
    }
    return self;
}

- (id)initWithURL:(NSString *)urlPath withPostParameters:(NSMutableDictionary *)postParameters withDelegate:(id <MSDownloadDelegate>)delegate andCacheLifetime:(MSDownloadCacheLifetime)lifetime {
    self = [super init];
    if (self) {
        _connectionURL = urlPath;
        _safeUrlString = [self safeText:_connectionURL];
        _postParameters = postParameters;
        _delegate = delegate;
        _cacheLifetime = lifetime;
    }
    return self;
}

- (id)initWithURL:(NSString *)urlPath withPostParameters:(NSMutableDictionary *)postParameters andUrlConnectionDelegate:(id<NSURLConnectionDelegate,NSURLConnectionDataDelegate>)delegate {
    self = [super init];
    if (self) {
        _connectionURL = urlPath;
        _safeUrlString = [self safeText:_connectionURL];
        _postParameters = postParameters;
        _connectionDelegate = delegate;
    }
    return self;
}

#pragma mark Operation methods

- (void)done {
    if(_connection) {
        [_connection cancel];
        _connection = nil;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    _executing = NO;
    _finished = YES;
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)cancel {
    [self done];
}

- (void)start {
    if(![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
        return;
    }
    
    if(_finished || [self isCancelled]) {
        [self done];
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    [self main];
}

- (void)main {
    @autoreleasepool {
        _safeUrlString = [self safeText:_connectionURL];
        _cacheFilePath = [self cacheFilePathConstruct];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:_cacheFilePath] && _cacheLifetime != MSDownloadCacheLifetimeNone) {
            NSData *data = [NSData dataWithContentsOfFile:_cacheFilePath];
            if ([_delegate respondsToSelector:@selector(download:didFinishLoadingWithData:)]) {
                [_delegate download:self didFinishLoadingWithData:data];
            }
            [self done];
        }
        else {
            NSURL *url = [[NSURL alloc] initWithString:_connectionURL];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setTimeoutInterval:8];
            if (_postParameters) {
                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_postParameters options:NSJSONWritingPrettyPrinted error:&error];
                NSString *requestJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                NSLog(@"JSONRequest: %@", requestJSON);
                
                NSData *requestData = [NSData dataWithBytes:[requestJSON UTF8String] length:[requestJSON length]];
                [request setHTTPMethod:@"POST"];
                [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:requestData];
            }
            _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        }
    }
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

#pragma mark Connection delegate methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if ([_connectionDelegate respondsToSelector:@selector(connection:didFailWithError:)]) {
        [_connectionDelegate connection:connection didFailWithError:error];
    }
    if ([_delegate respondsToSelector:@selector(download:didFinishLoadingWithError:)]) {
        [_delegate download:self didFinishLoadingWithError:error];
    }
    [self done];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([_connectionDelegate respondsToSelector:@selector(connection:didReceiveResponse:)]) {
        [_connectionDelegate connection:connection didReceiveResponse:response];
    }
    else {
        _totalDataSize = response.expectedContentLength;
        _receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if ([_connectionDelegate respondsToSelector:@selector(connection:didReceiveData:)]) {
        [_connectionDelegate connection:connection didReceiveData:data];
    }
    else {
        [_receivedData appendData:data];
        if ([_delegate respondsToSelector:@selector(download:didUpdatePercentageProgressStatus:)]) {
            CGFloat p = (([_receivedData length] * 100) / _totalDataSize);
            if (p > 100) p = 100;
            [_delegate download:self didUpdatePercentageProgressStatus:p];
            NSLog(@"Percent download: %f", p);
        }
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([_connectionDelegate respondsToSelector:@selector(connectionDidFinishLoading:)]) {
        [_connectionDelegate connectionDidFinishLoading:connection];
    }
    if ([_delegate respondsToSelector:@selector(download:didFinishLoadingWithData:)]) {
        if (_cacheLifetime != MSDownloadCacheLifetimeNone) [_receivedData writeToFile:_cacheFilePath atomically:YES];
        [_delegate download:self didFinishLoadingWithData:_receivedData];
    }
    [self done];
}


@end
