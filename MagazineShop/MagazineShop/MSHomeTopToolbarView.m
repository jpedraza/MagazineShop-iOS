//
//  MSHomeTopToolbarView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSHomeTopToolbarView.h"


@implementation MSHomeTopToolbarView


#pragma mark Creating elements

- (void)createTitleLabel {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 10, 24)];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    [_titleLabel setTextColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [_titleLabel setShadowColor:[UIColor darkGrayColor]];
    [_titleLabel setShadowOffset:CGSizeMake(1, 1)];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self addSubview:_titleLabel];
    [self setTitle:@"Lorem ipsum"];
}

- (void)createAllElements {
    [super createAllElements];
    
    [self setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth];
    CALayer *bottomBorder = [CALayer layer];
    [bottomBorder setFrame:CGRectMake(0, 43, self.width, 1)];
    [bottomBorder setBackgroundColor:[UIColor blackColor].CGColor];
    [self.layer addSublayer:bottomBorder];
    
    [self createTitleLabel];
}

#pragma mark Settings

- (void)setTitle:(NSString *)title {
    [_titleLabel setText:title];
    [_titleLabel sizeToFit];
    [_titleLabel centerHorizontally];
}


@end
