//
//  MSMagazineReaderBasicPageView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazineReaderBasicPageView.h"


@implementation MSMagazineReaderBasicPageView


#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [_imageView setBackgroundColor:[UIColor clearColor]];
    [_imageView setAutoresizingWidthAndHeight];
    
    [self addSubview:_imageView];
}

#pragma mark Settings

- (CGRect)frameForImage:(UIImage *)image inImageViewAspectFit:(UIImageView *)imageView {
    float imageRatio = image.size.width / image.size.height;
    float viewRatio = imageView.frame.size.width / imageView.frame.size.height;
    if (imageRatio < viewRatio) {
        float scale = imageView.frame.size.height / image.size.height;
        float width = scale * image.size.width;
        float topLeftX = (imageView.frame.size.width - width) * 0.5;
        return CGRectMake(topLeftX, 0, width, imageView.frame.size.height);
    }
    else {
        float scale = imageView.frame.size.width / image.size.width;
        float height = scale * image.size.height;
        float topLeftY = (imageView.frame.size.height - height) * 0.5;
        return CGRectMake(0, topLeftY, imageView.frame.size.width, height);
    }
}

- (void)setPageImage:(UIImage *)image {
    [_imageView setImage:image];
    CGRect r = [self frameForImage:image inImageViewAspectFit:_imageView];
    if (r.size.width < self.width) {
        r.origin.x = (_pageIndex % 2) ? (self.width - r.size.width) : 0;
    }
    [_imageView setFrame:r];
}

#pragma mark Initialization

- (void)configureView {
    [self setBackgroundColor:([MSConfig readerBackgroundColorIsBlack] ? [UIColor blackColor] : [UIColor whiteColor])];
}


@end
