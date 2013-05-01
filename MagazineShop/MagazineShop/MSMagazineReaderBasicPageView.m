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

- (void)setPageImage:(UIImage *)image {
    [_imageView setImage:image];
}

#pragma mark Initialization

- (void)configureView {
    [self setBackgroundColor:[UIColor alphaPatternImageColorWithSquareSide:20]];
}


@end
