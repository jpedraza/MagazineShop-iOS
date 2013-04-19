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

- (void)showSubscriptionsFromElement:(UIView *)element {
    MSSubscriptionsViewController *c = [[MSSubscriptionsViewController alloc] init];
    [super showViewController:c asPopoverFromView:element];
}

- (void)showSettingsFromElement:(UIView *)element {
    MSSettingsViewController *c = [[MSSettingsViewController alloc] init];
    [super showViewController:c asPopoverFromView:element];
}

- (void)changeMagazineListViewTo:(MSConfigMainMagazineListViewType)type {
    
}

#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark Magazine shop delegate & data source methods

- (void)magazineListView:(MSMagazineListView *)magazineView changedVisibilityStatus:(MSMagazineListViewVisibilityStatus)status {
    
}

#pragma mark Top toolbar delegate method

- (void)homeTopToolbar:(MSHomeTopToolbarView *)toolbar requestsFunctionality:(MSHomeTopToolbarViewFunctionality)functionality fromElement:(UIView *)element {
    NSLog(@"Requested functionality: %d", functionality);
    switch (functionality) {
        case MSHomeTopToolbarViewFunctionalitySubscriptions:
            [self showSubscriptionsFromElement:element];
            break;
            
        case MSHomeTopToolbarViewFunctionalitySettings:
            [self showSettingsFromElement:element];
            break;
            
        case MSHomeTopToolbarViewFunctionalitySingleView:
            [self changeMagazineListViewTo:MSConfigMainMagazineListViewTypeSigle];
            break;
            
        case MSHomeTopToolbarViewFunctionalityListView:
            [self changeMagazineListViewTo:MSConfigMainMagazineListViewTypeList];
            break;
            
        case MSHomeTopToolbarViewFunctionalityDenseListView:
            [self changeMagazineListViewTo:MSConfigMainMagazineListViewTypeDense];
            break;
            
        default:
            break;
    }
}


@end
