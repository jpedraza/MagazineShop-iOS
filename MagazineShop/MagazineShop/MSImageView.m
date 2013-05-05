//
//  MSImageView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSImageView.h"


@interface MSImageView ()

@property (nonatomic, strong) NSString *safeUrlString;
@property (nonatomic, strong) NSString *cacheFilePath;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic) NSInteger repeatedConnectionCounter;

@end


@implementation MSImageView


#pragma mark Url & caching

+ (NSString *)folderPath:(MSImageViewCacheLifetime)cacheLifetime {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"image-cache-%d", cacheLifetime]];
}

+ (void)clearCache:(MSImageViewCacheLifetime)cacheLifetime {
    // TODO: Clear only when connected to the internet!
    NSString *folderPath = [MSImageView folderPath:cacheLifetime];
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
    NSString *folderPath = [MSImageView folderPath:_cacheLifetime];
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

- (void)setupView {
    [self setContentMode:UIViewContentModeScaleAspectFill];
    [self setClipsToBounds:YES];
}

- (id)initWithFrame:(CGRect)frame withImageUrlString:(NSString *)url withDefaultImage:(UIImage *)defaultImage andCacheLifetime:(MSImageViewCacheLifetime)lifetime {
    self = [super initWithFrame:frame];
    if (self) {
        [self setImageUrlString:url withDefaultImage:defaultImage andCacheLifetime:lifetime];
        [self setupView];
    }
    return self;
}

- (id)initWithImageName:(NSString *)imageName {
    self = [super initWithImage:[UIImage imageNamed:imageName]];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    self = [super initWithImage:image highlightedImage:highlightedImage];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark Settings

- (void)setImageUrlString:(NSString *)url withDefaultImage:(UIImage *)defaultImage andCacheLifetime:(MSImageViewCacheLifetime)lifetime {
    _imageUrlString = url;
    _safeUrlString = [self safeText:_imageUrlString];
    _cacheLifetime = lifetime;
    _cacheFilePath = [self cacheFilePathConstruct];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:_cacheFilePath] && _cacheLifetime != MSImageViewCacheLifetimeNone) {
        NSData *imageData = [NSData dataWithContentsOfFile:_cacheFilePath];
        [self setImage:[UIImage imageWithData:imageData]];
    }
    else {
        [self setImage:defaultImage];
        [self startLoadingImage];
    }
}

#pragma mark Loading image

- (void)displayImageWithAnimation {
    __block UIView *v = [[UIView alloc] initWithFrame:self.bounds];
    [v setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.3]];
    [v setAlpha:0];
    [self addSubview:v];
    [UIView animateWithDuration:0.15 animations:^{
        [v setAlpha:1];
    } completion:^(BOOL finished) {
        [self setImage:[UIImage imageWithData:_receivedData]];
        [UIView animateWithDuration:0.15 animations:^{
            [v setAlpha:0];
        } completion:^(BOOL finished) {
            [v removeFromSuperview];
            v = nil;
        }];
    }];
}

-  (void)startLoadingImage {
    _repeatedConnectionCounter = 0;
    _statusCode = 0;
    _receivedData = [NSMutableData data];
    
    _download = [[MSDownload alloc] initWithURL:_imageUrlString withPostParameters:nil andUrlConnectionDelegate:self];
    __weak MSImageView *self_ = self;
    [_download setCompletionBlock:^{
        [self_ performSelectorOnMainThread:@selector(displayImageWithAnimation) withObject:nil waitUntilDone:NO];
    }];
    [_download setQueuePriority:NSOperationQueuePriorityHigh];
    [kDownloadOperation addOperation:_download];
    
    _repeatedConnectionCounter++;
}

#pragma mark Connection delgate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _statusCode = [(NSHTTPURLResponse *)response statusCode];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (_repeatedConnectionCounter <= 3) {
        [self startLoadingImage];
    }
    else {
        if ([_delegate respondsToSelector:@selector(imageView:didFinishWithError:)]) {
            [_delegate imageView:self didFinishWithError:error];
        }
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (_cacheLifetime != MSImageViewCacheLifetimeNone) [_receivedData writeToFile:_cacheFilePath atomically:YES];
    if ([_delegate respondsToSelector:@selector(imageView:didFinishLoadingImage:)]) {
        [_delegate imageView:self didFinishLoadingImage:self.image];
    }
}

#pragma mark Memory handling

- (void)dealloc {
    [_download cancel];
}




@end
