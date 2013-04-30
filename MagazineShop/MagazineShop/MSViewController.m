//
//  MSViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSViewController.h"


@interface MSViewController ()

@property (nonatomic, strong) UIView *popoverElement;

@end


@implementation MSViewController


#pragma mark Positioning

- (BOOL)isTablet {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

- (BOOL)isBigPhone {
    return ([[UIScreen mainScreen] bounds].size.height == 568);
}

- (CGFloat)screenHeight {
    CGFloat h = 0;
    if ([self isTablet]) {
        h = self.isLandscape ? 748 : 1004;
    }
    else {
        h = self.isLandscape ? 300 : ([self isBigPhone] ? 548 : 460);
    }
    return h;
}

- (CGFloat)screenWidth {
    CGFloat w = 0;
    if ([self isTablet]) {
        w = self.isLandscape ? 1024 : 768;
    }
    else {
        w = self.isLandscape ? ([self isBigPhone] ? 568 : 480) : 320;
    }
    return w;
}

- (void)layoutElements {
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
}

- (BOOL)isRetina {
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0));
}

#pragma mark Creating elements

- (void)createAllElements {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MS_bcg_main"]]];
}

#pragma mark Settings

- (void)setBackgroundImage:(NSString *)imageName {
    UIImage *img = [UIImage imageNamed:imageName];
    _backgroundImageView = [[UIImageView alloc] initWithImage:img];
    if (_backgroundImageView.height > self.view.height) {
        [_backgroundImageView setYOrigin:-20];
    }
    [self.view addSubview:_backgroundImageView];
}

#pragma mark Effects

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (void)showBlocker {
    _blocker = [[UIView alloc] initWithFrame:self.view.bounds];
    [_blocker setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
    [_blocker setUserInteractionEnabled:NO];
    [_blocker setAlpha:0];
    [_blocker setAutoresizingWidthAndHeight];
    [self.view addSubview:_blocker];
    [UIView animateWithDuration:0.3 animations:^{
        [_blocker setAlpha:1];
    }];
}

- (void)hideBlocker {
    [UIView animateWithDuration:0.3 animations:^{
        [_blocker setAlpha:0];
    } completion:^(BOOL finished) {
        [_blocker removeFromSuperview];
        _blocker = nil;
    }];
}

#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _isLandscape = UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLandscape = UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
    [self createAllElements];
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([self isTablet]) {
        return UIInterfaceOrientationMaskAll;
    }
    else {
        return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
    }
}

- (void)viewWillLayoutSubviews {
    self.isLandscape = UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
    [self layoutElements];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    self.isLandscape = UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    return YES;
}

#pragma mark Initialization

- (void)setupView {
    
}

- (id)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark Navigation

- (void)closeModal {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)pushViewController:(MSViewController *)controller {
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)showViewController:(MSViewController *)controller asPopoverFromView:(UIView *)view {
    _popoverElement = view;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:controller];
    [controller setContentSizeForViewInPopover:CGSizeMake(320, 316)];
    [nc setContentSizeForViewInPopover:CGSizeMake(320, 316)];
    _popover = [[UIPopoverController alloc] initWithContentViewController:nc];
    [_popover setPopoverContentSize:CGSizeMake(320, 360)];
    [_popover presentPopoverFromRect:view.bounds inView:view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

#pragma mark Progress HUD view methods

- (void)showHUDWithStyle:(MBProgressHUDMode)mode withTitle:(NSString *)title {
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_progressHUD setMode:mode];
    [_progressHUD setLabelText:title];
    [_progressHUD setAnimationType:MBProgressHUDAnimationFade];
    [_progressHUD setDelegate:self];
    [_progressHUD show:YES];
}

- (void)showHUDInWindowWithStyle:(MBProgressHUDMode)mode withTitle:(NSString *)title {
    _progressHUD = [[MBProgressHUD alloc] initWithWindow:[kAppDelegate window]];
    [_progressHUD setMode:mode];
    [_progressHUD setLabelText:title];
    [_progressHUD setAnimationType:MBProgressHUDAnimationFade];
    [_progressHUD setDelegate:self];
    [_progressHUD show:YES];
}

- (void)hideHUD {
    if (_progressHUD) {
        [_progressHUD hide:YES];
    }
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
	[_progressHUD removeFromSuperview];
	_progressHUD = nil;
}


#pragma mark Popover controller delegate methods

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    _popover = nil;
    _popoverElement = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return YES;
}


@end
