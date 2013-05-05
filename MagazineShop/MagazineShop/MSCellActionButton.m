//
//  MSCellActionButton.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 05/05/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSCellActionButton.h"


@implementation MSCellActionButton


#pragma mark Settings

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if (enabled) {
        [self setAlpha:1];
    }
    else {
        [self setAlpha:0.5];
    }
}


@end
