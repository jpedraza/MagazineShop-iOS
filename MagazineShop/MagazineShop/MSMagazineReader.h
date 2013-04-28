//
//  MSMagazineReader.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSMagazineReaderData.h"
#import "MSMagazineReaderCurledPageViewController.h"
#import "MSMagazineReaderFlatPageViewController.h"


typedef enum {
    MSMagazineReaderDisplayTypeSingleCurlPage,
    MSMagazineReaderDisplayTypeDoubleCurlPageOnLandscape,
    MSMagazineReaderDisplayTypeFlatBrowser
} MSMagazineReaderDisplayType;


@interface MSMagazineReader : NSObject

@property (nonatomic, readonly) MSMagazineReaderDisplayType displayType;
@property (nonatomic, strong, readonly) MSMagazineReaderData *magazineData;

- (MSMagazineReaderCurledPageViewController *)curledViewController;
- (MSMagazineReaderFlatPageViewController *)flatViewController;

- (id)initWithType:(MSMagazineReaderDisplayType)type;


@end
