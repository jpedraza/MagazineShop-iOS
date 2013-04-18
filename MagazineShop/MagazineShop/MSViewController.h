//
//  MSViewController.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MSViewController : UIViewController

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic) BOOL isLandscape;

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
- (void)pushViewController:(MSViewController *)controller;
- (void)closeModal;


@end
