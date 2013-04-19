//
//  MSHomeViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSHomeViewController.h"


@interface MSHomeViewController ()

@property (nonatomic, strong) MSHomeTopToolbarView *topToolbar;
@property (nonatomic, strong) MSHomeBottomToolbarView *bottomToolbar;

@end


@implementation MSHomeViewController


#pragma mark Layout

- (void)layoutElements {
    [super layoutElements];
    if (self.isLandscape) {
        [_topToolbar setWidth:[super screenWidth]];
        [_bottomToolbar setWidth:[super screenWidth]];
        [_bottomToolbar setYOrigin:([super screenHeight] - 49)];
    }
}

#pragma mark Creating elements

- (void)createToolbars {
    CGRect r = CGRectMake(0, 0, [super screenWidth], 44);
    _topToolbar = [[MSHomeTopToolbarView alloc] initWithFrame:r];
    [_topToolbar setDelegate:self];
    [_topToolbar setTitle:@"Lorem ipsum"];
    [self.view addSubview:_topToolbar];
    
    r.size.height = 49;
    r.origin.y = ([super screenHeight] - r.size.height);
    _bottomToolbar = [[MSHomeBottomToolbarView alloc] initWithFrame:r];
    [self.view addSubview:_bottomToolbar];
}

- (void)createAllElements {
    [super createAllElements];
    [self createToolbars];
}

#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark Top toolbar delegate method

- (void)homeTopToolbar:(MSHomeTopToolbarView *)toolbar requestsFunctionality:(MSHomeTopToolbarViewFunctionality)functionality fromElement:(UIView *)element {
    NSLog(@"Requested functionality: %d", functionality);
}


@end
