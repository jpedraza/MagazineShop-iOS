//
//  MSMagazines.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 05/05/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MSMagazines : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSNumber *downloadStatus;
@property (nonatomic, retain) NSNumber *purchaseSatus;
@property (nonatomic, retain) NSNumber *availabilityStatus;
@property (nonatomic, retain) NSNumber *size;
@property (nonatomic, retain) NSData *coverImage;
@property (nonatomic, retain) NSData *thumbnailImage;


@end
