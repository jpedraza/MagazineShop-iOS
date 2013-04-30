//
//  MSMagazineReaderBasicPageView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazineReaderBasicPageView.h"


@implementation MSMagazineReaderBasicPageView


#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor alphaPatternImageColorWithSquareSide:20]];
    }
    return self;
}


@end
