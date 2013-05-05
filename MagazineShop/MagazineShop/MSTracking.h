//
//  MSTracking.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MSTracking : NSObject

+ (void)initTrackingSessions;
+ (void)logEvent:(NSString *)event;


@end
