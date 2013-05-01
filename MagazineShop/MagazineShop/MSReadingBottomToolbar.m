//
//  MSReadingBottomToolbar.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 30/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSReadingBottomToolbar.h"


@implementation MSReadingBottomToolbar


#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
    
    [self setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth];
    CALayer *topBorder = [CALayer layer];
    [topBorder setFrame:CGRectMake(0, 0, ([super isTablet] ? 1024 : 320), 1)];
    [topBorder setBackgroundColor:[UIColor darkGrayColor].CGColor];
    [self.layer addSublayer:topBorder];
}


@end
