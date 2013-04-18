//
//  MSHomeBottomToolbarView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSHomeBottomToolbarView.h"

@implementation MSHomeBottomToolbarView


#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
    
    [self setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth];
    CALayer *topBorder = [CALayer layer];
    [topBorder setFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    [topBorder setBackgroundColor:[UIColor blackColor].CGColor];
    [self.layer addSublayer:topBorder];
}


@end
