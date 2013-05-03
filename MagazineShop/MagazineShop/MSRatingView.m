//
//  RateView.m
//  CustomView
//
//  Created by Ray Wenderlich on 7/30/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "MSRatingView.h"

@implementation MSRatingView

@synthesize notSelectedImage = _notSelectedImage;
@synthesize halfSelectedImage = _halfSelectedImage;
@synthesize fullSelectedImage = _fullSelectedImage;
@synthesize rating = _rating;
@synthesize editable = _editable;
@synthesize delegate = _delegate;

#pragma mark Main
- (void)baseInit {

}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		
		imageViews = [NSMutableArray array];
		_notSelectedImage = nil;
		_halfSelectedImage = nil;
		_fullSelectedImage = nil;
		_rating = 0;
		_editable = YES;
		self.backgroundColor = [UIColor clearColor];
        
		for (int i = 0; i < 5; i++) {
			UIImageView *imageView = [[UIImageView alloc] init];
			[imageViews addObject:imageView];
			[self addSubview:imageView];
		}
    }
    return self;
}

#pragma mark Refresh + ReLayout

- (void)refresh {
    for(int i = 0; i < [imageViews count]; ++i) {
        UIImageView *imageView = [imageViews objectAtIndex:i];
        if (_rating >= i+1) {
            imageView.image = _fullSelectedImage;
        } else if (_rating > i) {
            imageView.image = _halfSelectedImage;
        } else {
            imageView.image = _notSelectedImage;
        }
    }
}

- (void)setRating:(float)number {
	_rating = number;
	[self refresh];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_notSelectedImage == nil) return;

    for (int i = 0; i < [imageViews count]; i++) {
        UIImageView *imageView = [imageViews objectAtIndex:i];
        CGRect imageFrame = CGRectMake(22 * i, 0, 22, 24);
        imageView.frame = imageFrame;        
    }
}

#pragma mark Setting Properties

- (void)setNotSelectedImage:(UIImage *)image {
    _notSelectedImage = image;
    [self refresh];
}

- (void)setHalfSelectedImage:(UIImage *)image {
    _halfSelectedImage = image;
    [self refresh];
}

- (void)setFullSelectedImage:(UIImage *)image {
    _fullSelectedImage = image;
    [self refresh];
}

#pragma mark Touch detection

- (void)handleTouchAtLocation:(CGPoint)touchLocation {
    if (!_editable) return;
    
    _rating = 0;
    for(int i = [imageViews count] - 1; i >= 0; i--) {
        UIImageView *imageView = [imageViews objectAtIndex:i];        
        if (touchLocation.x > imageView.frame.origin.x) {
            _rating = i+1;
            break;
        }
    }
    
    [self refresh];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_delegate ratingView:self ratingDidChange:_rating];
}

@end
