//
//  MSDataHolder.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 30/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MSProduct;

@interface MSDataHolder : NSObject

@property (nonatomic, strong) NSMutableArray *products;

+ (MSDataHolder *)sharedObject;

- (MSProduct *)productAtIndex:(NSInteger)index;
- (MSProduct *)productForIdentifier:(NSString *)identifier;



@end
