//
//  MSToolbarView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSToolbarView.h"

@implementation MSToolbarView


#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
    
    [self setBackgroundColor:[UIColor colorWithHexString:@"232323"]];
}

#pragma mark Settings

- (void)addSubview:(UIView *)view {
    [view setAlpha:0];
    [super addSubview:view];
}

- (void)setElementsAlpha:(CGFloat)alpha {
    for (UIView *v in self.subviews) {
        [v setAlpha:alpha];
    }
}

- (void)showElements:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [self setElementsAlpha:1];
        }];
    }
    else {
        [self setElementsAlpha:1];
    }
}


@end
