//
//  MSConfig.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark Debug variables

#define kDebug                                              YES
#define kDegugClearCache                                    YES
#define kDebugLabels                                        NO

#pragma mark Api variables

#define kMSConfigBaseUrl                                    @"http://fuertemag.fuerteint.com/"
#define kMSConfigMinPagesForRead                            10


typedef enum {
    MSConfigMainMagazineListViewTypeSigle,
    MSConfigMainMagazineListViewTypeList,
    MSConfigMainMagazineListViewTypeDense
} MSConfigMainMagazineListViewType;


@interface MSConfig : NSObject



@end
