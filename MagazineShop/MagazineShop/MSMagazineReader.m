//
//  MSMagazineReader.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineReader.h"


@implementation MSMagazineReader


#pragma mark Initialization

- (id)initWithType:(MSMagazineReaderDisplayType)type {
    self = [super init];
    if (self) {
        _displayType = type;
    }
    return self;
}


@end
