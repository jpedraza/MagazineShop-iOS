//
//  SKProduct+Tools.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 20/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "SKProduct+Tools.h"


@implementation SKProduct (Tools)

- (NSString *) priceAsString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:[self priceLocale]];
    
    NSString *str = [formatter stringFromNumber:[self price]];
    return str;
}


@end
