//
//  MSLang.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>


#define MSLangGet(key) [MSLang get:key]


@interface MSLang : NSObject

+ (NSString *)get:(NSString *)key;


@end
