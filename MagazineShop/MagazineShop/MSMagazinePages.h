//
//  MSMagazinePages.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 05/05/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MSMagazinePages : NSManagedObject

@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSNumber *pageNumber;
@property (nonatomic, retain) NSString *path;
@property (nonatomic, retain) NSNumber *pageSize;
@property (nonatomic, retain) NSNumber *size;
@property (nonatomic, retain) NSNumber *format;
@property (nonatomic, retain) NSNumber *pageType;
@property (nonatomic, retain) NSString *background;
@property (nonatomic, retain) NSData *guidedView;


@end
