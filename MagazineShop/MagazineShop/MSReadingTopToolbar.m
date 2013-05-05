//
//  MSReadingTopToolbar.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 30/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSReadingTopToolbar.h"


@implementation MSReadingTopToolbar


#pragma mark Creating elements

- (void)createTitleLabel {
    if ([super isTablet]) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 10, 24)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor colorWithWhite:0.95 alpha:1]];
        [_titleLabel setShadowColor:[UIColor darkGrayColor]];
        [_titleLabel setShadowOffset:CGSizeMake(1, 1)];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_titleLabel setAutoresizingCenter];
        [self addSubview:_titleLabel];
    }
}

- (void)createCloseButton {
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setFrame:CGRectMake(20, 5, 84, 34)];
    [_closeButton setTitle:MSLangGet(@"Close") forState:UIControlStateNormal];
    [_closeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_closeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [self addSubview:_closeButton];
}

- (void)createAllElements {
    [super createAllElements];
    
    [self setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth];
    CALayer *bottomBorder = [CALayer layer];
    [bottomBorder setFrame:CGRectMake(0, 43, 1024, 1)];
    [bottomBorder setBackgroundColor:[UIColor darkTextColor].CGColor];
    [self.layer addSublayer:bottomBorder];
    
    [self createCloseButton];
    [self createTitleLabel];
}

#pragma mark Settings

- (void)setTitle:(NSString *)title {
    [_titleLabel setText:title];
    [_titleLabel sizeToFit];
    [_titleLabel centerHorizontally];
}


@end
