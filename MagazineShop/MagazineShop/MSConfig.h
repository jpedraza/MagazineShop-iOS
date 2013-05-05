//
//  MSConfig.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark Debug variables

#define kDebug                                              NO
#define kDegugClearCache                                    NO
#define kDebugLabels                                        NO

#pragma mark Api variables

#define kMSConfigBaseUrl                                    @"http://fuertemag.fuerteint.com/"
#define kMSConfigMinPagesForRead                            10

#pragma mark Keychain

#define kMSConfigKeychainServiceName                        @"com.publishthemag.exampleapp"


typedef enum {
    MSConfigMainMagazineListViewTypeSigle,
    MSConfigMainMagazineListViewTypeList,
    MSConfigMainMagazineListViewTypeDense
} MSConfigMainMagazineListViewType;

typedef enum {
    MSConfigMagazineDisplayModeCurlDoubleSidedInLandscape,
    MSConfigMagazineDisplayModeCurlSingle,
    MSConfigMagazineDisplayModeFlat
} MSConfigMagazineDisplayMode;


@interface MSConfig : NSObject

+ (void)setMagazineDisplayMode:(MSConfigMagazineDisplayMode)displayMode;
+ (MSConfigMagazineDisplayMode)magazineDisplayMode;

+ (void)setScrollInLandscapeMode:(BOOL)scroll;
+ (BOOL)scrollInLandscapeMode;

+ (void)setReaderBackgroundColorIsBlack:(BOOL)isBlack;
+ (BOOL)readerBackgroundColorIsBlack;

+ (NSString *)appSqlFileName;
+ (NSString *)documentsDirectory;
+ (NSURL *)documentsDirectoryUrl;

+ (NSString *)getAppUUID;

+ (NSString *)formattedStringFromDate:(NSDate *)date;

+ (CGFloat)getKilobites:(CGFloat)bytes;
+ (CGFloat)getMegabites:(CGFloat)bytes;
+ (CGFloat)getKilobytes:(CGFloat)bytes;
+ (CGFloat)getMegabytes:(CGFloat)bytes;


@end
