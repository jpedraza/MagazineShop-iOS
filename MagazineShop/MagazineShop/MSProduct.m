//
//  MSProduct.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSProduct.h"


@implementation MSProduct


#pragma mark Settings

- (void)fillDataFromDictionary:(NSDictionary *)data {
    _originalInfoDictionary = data;
    _name = [data objectForKey:@"name"];
    _info = [data objectForKey:@"info"];
    _thumbnail = [data objectForKey:@"thumbnail"];
    _cover = [data objectForKey:@"cover"];
    _identifier = [data objectForKey:@"identifier"];
    _date = [data objectForKey:@"date"];
}

@end
