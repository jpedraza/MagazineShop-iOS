//
//  MSAppDelegate.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSAppDelegate.h"
#import "MSHomeViewController.h"
#import "MSImageView.h"
#import "MSDownload.h"


@interface MSAppDelegate ()

@end


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

#pragma mark Core data methods

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath:[[MSConfig documentsDirectory] stringByAppendingPathComponent:[MSConfig appSqlFileName]]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        NSLog(@"Core data error: %@", [error localizedDescription]);
    }
    return _persistentStoreCoordinator;
}

- (void)saveContext {
    NSError *error;
    [kManagedObject save:&error];
    if (error) {
        NSLog(@"Error updating data: %@", [error localizedDescription]);
    }
}

#pragma mark App delegate methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Reachability
    _reachability = kReachability;
    
    // Initialize tracing
    [MSTracking initTrackingSessions];
    
    // First launch
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [MSConfig setMagazineDisplayMode:MSConfigMagazineDisplayModeCurlSingle];
        [MSConfig setScrollInLandscapeMode:YES];
        [MSConfig setReaderBackgroundColorIsBlack:YES];
    }
    
    // Handle caching
    if (kDegugClearCache) {
        [MSImageView clearCache:MSImageViewCacheLifetimeTerminate];
        [MSDownload clearCache:MSDownloadCacheLifetimeTerminate];
        if (kDebug) {
            [MSImageView clearCache:MSImageViewCacheLifetimeForever];
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
