//
//  MSTracking.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSTracking.h"
#import "Flurry.h"


@implementation MSTracking

+ (void)initTrackingSessions {
    [Flurry startSession:@"TRACKING-KEY"];
}

+ (void)logEvent:(NSString *)event {
    [Flurry logEvent:event];
}


@end
