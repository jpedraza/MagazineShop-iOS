//
//  MSView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSView.h"


@implementation MSView


#pragma mark Creating elements

- (void)createAllElements {
    
}

#pragma mark Environment

- (BOOL)isRetina {
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0));
}

- (BOOL)isBigPhone {
    return ([[UIScreen mainScreen] bounds].size.height == 568);
}

#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createAllElements];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self createAllElements];
    }
    return self;
}


@end
