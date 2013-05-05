//
//  MSAppDelegate.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSInAppPurchase.h"
#import "GCNetworkReachability.h"


#define kAppDelegate                                        (MSAppDelegate *)[[UIApplication sharedApplication] delegate]
#define kDownloadOperation                                  [kAppDelegate downloadOperationQueue]
#define kProcessingOperation                                [kAppDelegate processingOperationQueue]

#define kReachability                                       [GCNetworkReachability reachabilityWithHostName:@"www.google.com"]


@class MSHomeViewController;

@interface MSAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) MSHomeViewController *homeViewController;

@property (nonatomic, strong) MSInAppPurchase *inAppPurchase;

@property (nonatomic, strong) NSOperationQueue *downloadOperationQueue;
@property (nonatomic, strong) NSOperationQueue *processingOperationQueue;

@property (nonatomic, strong) GCNetworkReachability *reachability;


@end
