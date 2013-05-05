//
//  MSLang.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSLang.h"


@implementation MSLang

+ (NSString *)get:(NSString *)key {
    return NSLocalizedString(key, nil);
}


@end
