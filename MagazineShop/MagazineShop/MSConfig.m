//
//  MSConfig.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSConfig.h"


#define kMSConfigMagazineDisplayKey                                     @"MSConfigMagazineDisplayKey"
#define kMSConfigMagazineScrollInLandscape                              @"MSConfigMagazineScrollInLandscape"
#define kMSConfigMagazineReaderBcg                                      @"MSConfigMagazineReaderBcg"


@implementation MSConfig


#pragma mark Settings

+ (void)setMagazineDisplayMode:(MSConfigMagazineDisplayMode)displayMode {
    [[NSUserDefaults standardUserDefaults] setInteger:displayMode forKey:kMSConfigMagazineDisplayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (MSConfigMagazineDisplayMode)magazineDisplayMode {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kMSConfigMagazineDisplayKey];
}

+ (void)setScrollInLandscapeMode:(BOOL)scroll {
    [[NSUserDefaults standardUserDefaults] setBool:scroll forKey:kMSConfigMagazineScrollInLandscape];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)scrollInLandscapeMode {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kMSConfigMagazineScrollInLandscape];
}

+ (void)setReaderBackgroundColorIsBlack:(BOOL)isBlack {
    [[NSUserDefaults standardUserDefaults] setBool:isBlack forKey:kMSConfigMagazineReaderBcg];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)readerBackgroundColorIsBlack {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kMSConfigMagazineReaderBcg];
}


@end
