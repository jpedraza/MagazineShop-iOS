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

- (id)init {
    NSAssert(YES, @"Please use - (id)initWithType:(MSMagazineReaderDisplayType)type; instead!");
    return nil;
}

- (id)initWithType:(MSMagazineReaderDisplayType)type {
    self = [super init];
    if (self) {
        _displayType = type;
        _magazineData = [[MSMagazineReaderData alloc] init];
    }
    return self;
}

#pragma mark Getting controllers

- (MSMagazineReaderCurledPageViewController *)curledViewController {
    MSMagazineReaderCurledPageViewController *c = [[MSMagazineReaderCurledPageViewController alloc] init];
    [c setMagazineDataSource:_magazineData];
    [c setMagazineDelegate:_magazineData];
    return c;
}

- (MSMagazineReaderFlatPageViewController *)flatViewController {
    MSMagazineReaderFlatPageViewController *c = [[MSMagazineReaderFlatPageViewController alloc] init];
    [c setMagazineDataSource:_magazineData];
    [c setMagazineDelegate:_magazineData];
    return c;
}


@end
