//
//  MSConfig.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSConfig.h"
#import "MSKeychainObject.h"


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

#pragma mark Text formatting

+ (NSString *)appSqlFileName {
    return [NSString stringWithFormat:@"%@.sqlite", [[NSBundle mainBundle] bundleIdentifier]];
}

+ (NSString *)documentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSURL *)documentsDirectoryUrl {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark UUID

+ (NSString *)getNewUUID {
    NSString *result = nil;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    assert(uuidStr != NULL);
    result = [(__bridge NSString *)uuidStr copy];
    CFRelease(uuidStr);
    return result;
}

+ (NSString *)getAppUUID {
    NSString *uuid = [MSKeychainObject sharedKeychainObject].uuid;
    if (!uuid || [uuid length] < 5) {
        uuid = [self getNewUUID];
        [[MSKeychainObject sharedKeychainObject] setUuid:uuid];
    }
    return uuid;
}

+ (NSString *)getAuthToken {
    return [MSKeychainObject sharedKeychainObject].authToken;
}

#pragma mark Text formatting

+ (NSString *)formattedStringFromDate:(NSDate *)date {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateStyle:NSDateFormatterMediumStyle];
    [f setTimeStyle:NSDateFormatterMediumStyle];
    return [f stringFromDate:date];
}

+ (CGFloat)getKilobites:(CGFloat)bytes {
    return (bytes / 128);
}

+ (CGFloat)getMegabites:(CGFloat)bytes {
    return (bytes / 131072);
}

+ (CGFloat)getKilobytes:(CGFloat)bytes {
    return (bytes / 1024);
}

+ (CGFloat)getMegabytes:(CGFloat)bytes {
    return ([self getKilobytes:bytes] / 1024);
}




@end
