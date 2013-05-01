//
//  MSMagazineReaderCurledPageViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazineReaderViewController.h"
#import "MSReadingTopToolbar.h"
#import "MSReadingBottomToolbar.h"


@interface MSMagazineReaderViewController ()

@property (nonatomic, strong) MSReadingTopToolbar *topToolbar;
@property (nonatomic, strong) MSReadingBottomToolbar *bottomToolbar;

@end


@implementation MSMagazineReaderViewController


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

- (BOOL)isRetina {
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0));
}

- (void)layoutElements {
    if (self.isLandscape) {
        [_topToolbar setWidth:[self screenWidth]];
        [_bottomToolbar setWidth:[self screenWidth]];
        [_bottomToolbar setYOrigin:([self screenHeight] - 49)];
    }
}

#pragma mark Creating elements

- (void)createToolbars {
    CGRect r = CGRectMake(0, 0, [self screenWidth], 44);
    _topToolbar = [[MSReadingTopToolbar alloc] initWithFrame:r];
    [_topToolbar.closeButton addTarget:self action:@selector(didClickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [_topToolbar setTitle:self.title];
    [self.view addSubview:_topToolbar];
    
    r.size.height = 49;
    r.origin.y = ([self screenHeight] - r.size.height);
    _bottomToolbar = [[MSReadingBottomToolbar alloc] initWithFrame:r];
    [self.view addSubview:_bottomToolbar];
}

- (void)createAllElements {
    [self createToolbars];
}

#pragma mark Actions

- (void)didClickCloseButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _isLandscape = UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
}

- (void)showToolbarContent {
    [_topToolbar showElements:YES];
    [_bottomToolbar showElements:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showToolbarContent) userInfo:nil repeats:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isLandscape = UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
    [self createAllElements];
    
    [self setDataSource:_data];
    [self setDelegate:_data];
    
    NSArray *viewControllers = @[[_data pageViewControllerWithIndex:0]];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
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
    _isLandscape = UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
    [self layoutElements];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    _isLandscape = UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    return YES;
}


@end
