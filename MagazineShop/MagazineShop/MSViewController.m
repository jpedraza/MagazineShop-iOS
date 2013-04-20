//
//  MSViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
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
        h = self.isLandscape ? 300 : ([self isBigPhone] ? 568 : 480);
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MS_bcg_main.png"]]];
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
    [controller setContentSizeForViewInPopover:CGSizeMake(320, 360)];
    _popover = [[UIPopoverController alloc] initWithContentViewController:controller];
    [_popover setPopoverContentSize:CGSizeMake(320, 360)];
    [_popover presentPopoverFromRect:view.bounds inView:view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
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
