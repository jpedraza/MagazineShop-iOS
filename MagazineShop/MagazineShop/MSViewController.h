//
//  MSViewController.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface MSViewController : UIViewController <UIPopoverControllerDelegate, MBProgressHUDDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic) BOOL isLandscape;

@property (nonatomic, strong, readonly) MBProgressHUD *progressHUD;

// Positioning
- (CGFloat)screenHeight;
- (CGFloat)screenWidth;
- (BOOL)isTablet;
- (BOOL)isBigPhone;
- (BOOL)isRetina;

// Creating and configuring view
- (void)setBackgroundImage:(NSString *)imageName;
- (void)setupView;
- (void)layoutElements;
- (void)createAllElements;

// Navigation
- (void)showViewController:(MSViewController *)controller asPopoverFromView:(UIView *)view;
- (void)pushViewController:(MSViewController *)controller;
- (void)closeModal;

- (void)showHUDWithStyle:(MBProgressHUDMode)mode withTitle:(NSString *)title;
- (void)hideHUD;

// Alerts
- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;

@end
