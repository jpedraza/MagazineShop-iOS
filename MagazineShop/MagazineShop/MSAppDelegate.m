//
//  MSAppDelegate.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSAppDelegate.h"
#import "MSHomeViewController.h"
#import "MSImageView.h"
#import "MSDownload.h"


@implementation MSAppDelegate


#pragma mark Operation queues

- (void)createOperationQueues {
    _downloadOperationQueue = [[NSOperationQueue alloc] init];
    [_downloadOperationQueue setMaxConcurrentOperationCount:2];
    [_downloadOperationQueue cancelAllOperations];
    
    _processingOperationQueue = [[NSOperationQueue alloc] init];
    [_processingOperationQueue setMaxConcurrentOperationCount:1];
    [_processingOperationQueue cancelAllOperations];
}

#pragma mark App delegate methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Initialize tracing
    [MSTracking initTrackingSessions];
    
    // Handle caching
    if (kDegugClearCache) {
        [MSImageView clearCache:MSImageViewCacheLifetimeTerminate];
        [MSDownload clearCache:MSDownloadCacheLifetimeTerminate];
        if (kDebug) {
            [MSImageView clearCache:MSImageViewCacheLifetimeSession];
            [MSImageView clearCache:MSImageViewCacheLifetimeForever];
            [MSDownload clearCache:MSDownloadCacheLifetimeSession];
            [MSDownload clearCache:MSDownloadCacheLifetimeForever];
        }
    }
    
    // Operations
    [self createOperationQueues];
    
    // In app purchase
    _inAppPurchase = [[MSInAppPurchase alloc] init];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:_inAppPurchase];
    
    // Notifications
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeNewsstandContentAvailability];
    
    // App stuff :)
    _homeViewController = [[MSHomeViewController alloc] init];
    
    _window.rootViewController = _homeViewController;
    [_window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (kDegugClearCache) {
        [MSImageView clearCache:MSImageViewCacheLifetimeSession];
        [MSDownload clearCache:MSDownloadCacheLifetimeSession];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
