//
//  MSConfig.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSConfig.h"


#define kMSConfigMagazineDisplayKey                            @""


@implementation MSConfig


#pragma mark Settings

+ (void)setMagazineDisplayMode:(MSConfigMagazineDisplayMode)displayMode {
    [[NSUserDefaults standardUserDefaults] setInteger:displayMode forKey:kMSConfigMagazineDisplayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (MSConfigMagazineDisplayMode)magazineDisplayMode {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kMSConfigMagazineDisplayKey];
}


@end
