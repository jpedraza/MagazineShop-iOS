//
//  MSConfig.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kDebug                                              YES

#define kMSConfigBaseUrl                                    @"http://fuertemag.fuerteint.com/"


typedef enum {
    MSConfigMainMagazineListViewTypeSigle,
    MSConfigMainMagazineListViewTypeList,
    MSConfigMainMagazineListViewTypeDense
} MSConfigMainMagazineListViewType;


@interface MSConfig : NSObject

@end
