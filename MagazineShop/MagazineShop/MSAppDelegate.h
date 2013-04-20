//
//  MSAppDelegate.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kAppDelegate                            (MSAppDelegate *)[[UIApplication sharedApplication] delegate]


@class MSHomeViewController;

@interface MSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MSHomeViewController *homeViewController;


@end
