//
//  MSImageView.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSDownload.h"


typedef enum {
    MSImageViewCacheLifetimeNone,
    MSImageViewCacheLifetimeForever,
    MSImageViewCacheLifetimeSession,
    MSImageViewCacheLifetimeTerminate
} MSImageViewCacheLifetime;


@class MSImageView;

@protocol MSImageViewDelegate <NSObject>

@optional
- (void)imageView:(MSImageView *)connector didFinishLoadingImage:(UIImage *)image;
- (void)imageView:(MSImageView *)connector didFinishWithError:(NSError *)error;

@end


@interface MSImageView : UIImageView <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, readonly) MSImageViewCacheLifetime cacheLifetime;
@property (nonatomic, strong, readonly) NSString *imageUrlString;

@property (nonatomic, strong, readonly) MSDownload *download;
@property (nonatomic, readonly) NSInteger statusCode;
@property (nonatomic, readonly) BOOL receivedMessageOK;

@property (nonatomic, weak) id <MSImageViewDelegate> delegate;


+ (void)clearCache:(MSImageViewCacheLifetime)cacheLifetime;

- (id)initWithFrame:(CGRect)frame withImageUrlString:(NSString *)url withDefaultImage:(UIImage *)defaultImage andCacheLifetime:(MSImageViewCacheLifetime)lifetime;
- (id)initWithImageName:(NSString *)imageName;

- (void)setImageUrlString:(NSString *)url withDefaultImage:(UIImage *)defaultImage andCacheLifetime:(MSImageViewCacheLifetime)lifetime;


@end
