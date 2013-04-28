//
//  MSDownload.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSDownload.h"


@interface MSDownload ()

@property (nonatomic, strong) NSMutableData *receivedData;

@end


@implementation MSDownload


#pragma mark Initialization

- (id)initWithURL:(NSString *)urlPath andDelegate:(id <MSDownloadDelegate>)delegate {
    
}

- (id)initWithURL:(NSString *)urlPath withPostParameters:(NSMutableDictionary *)postParameters andDelegate:(id <MSDownloadDelegate>)delegate {
    
}

- (id)initWithURL:(NSString *)urlPath withPostParameters:(NSMutableDictionary *)postParameters andUrlConnectionDelegate:(id<NSURLConnectionDelegate,NSURLConnectionDataDelegate>)delegate {
    self = [super init];
    if (self) {
        _connectionURL = urlPath;
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
        _receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if ([_connectionDelegate respondsToSelector:@selector(connection:didReceiveData:)]) {
        [_connectionDelegate connection:connection didReceiveData:data];
    }
    else {
        [_receivedData appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([_connectionDelegate respondsToSelector:@selector(connectionDidFinishLoading:)]) {
        [_connectionDelegate connectionDidFinishLoading:connection];
    }
    if ([_delegate respondsToSelector:@selector(download:didFinishLoadingWithData:)]) {
        [_delegate download:self didFinishLoadingWithData:_receivedData];
    }
    [self done];
}


@end
