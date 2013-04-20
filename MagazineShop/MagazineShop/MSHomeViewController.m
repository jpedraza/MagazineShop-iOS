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

@property (nonatomic, strong) MSMagazineView *magazineView;

@end


@implementation MSHomeViewController


#pragma mark Positioning

- (CGRect)freeSpaceRect {
    return CGRectMake(0, _topToolbar.bottom, [super screenWidth], ([super screenHeight] - _topToolbar.height - _bottomToolbar.height));
}

#pragma mark Layout

- (void)layoutElements {
    [super layoutElements];
    if (self.isLandscape) {
        [_topToolbar setWidth:[super screenWidth]];
        [_bottomToolbar setWidth:[super screenWidth]];
        [_bottomToolbar setYOrigin:([super screenHeight] - 49)];
    }
    [UIView animateWithDuration:0.3 animations:^{
        [_magazineView setFrame:[self freeSpaceRect]];
    }];
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

- (void)createMagazineView {
    _magazineView = [[MSMagazineView alloc] initWithFrame:[self freeSpaceRect]];
    [_magazineView setDelegate:self];
    [_magazineView setMagazineDelegate:self];
    [self.view addSubview:_magazineView];
}

- (void)createAllElements {
    [super createAllElements];
    [self createToolbars];
    [self createMagazineView];
}

- (void)showSubscriptionsFromElement:(UIView *)element {
    if ([SKPaymentQueue canMakePayments]) {
        MSSubscriptionsViewController *c = [[MSSubscriptionsViewController alloc] init];
        [c setTitle:MSLangGet(@"Subscriptions")];
        if ([super isTablet]) {
            [super showViewController:c asPopoverFromView:element];
        }
        else {
            [c setModalTransitionStyle:UIModalTransitionStylePartialCurl];
            [super presentViewController:c animated:YES completion:^{
                
            }];
        }
    }
    else {
        [super showAlertWithTitle:MSLangGet(@"Payment error") andMessage:MSLangGet(@"Payments are not enabled on this device!")];
    }
}

- (void)showSettingsFromElement:(UIView *)element {
    MSSettingsViewController *c = [[MSSettingsViewController alloc] init];
    [c setTitle:MSLangGet(@"Settings")];
    if ([super isTablet]) {
        [super showViewController:c asPopoverFromView:element];
    }
    else {
        [c setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        [super presentViewController:c animated:YES completion:^{
            
        }];
    }
}

- (void)changeMagazineListViewTo:(MSConfigMainMagazineListViewType)type {
    
}

#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_magazineView loadProducts];
}

#pragma mark Magazine shop delegate & data source methods

- (void)magazineListView:(MSMagazineListView *)magazineView changedVisibilityStatus:(MSMagazineListViewVisibilityStatus)status {
    
}

#pragma mark Magazine view delegate methods

- (void)magazineViewDidStartLoadingData:(MSMagazineView *)view {
    [super showBlocker];
    [super showHUDWithStyle:MBProgressHUDModeIndeterminate withTitle:MSLangGet(@"Loading products ...")];
}

- (void)magazineViewDidFinishLoadingData:(MSMagazineView *)view {
    [super hideBlocker];
    [super hideHUD];
    [_topToolbar showElements:YES];
    [_bottomToolbar showElements:YES];
}

#pragma mark Subscription controller delegate methods

- (void)subscriptionController:(MSSubscriptionsViewController *)controller requestsPurchaseForProduct:(SKProduct *)product {
    
}

- (void)subscriptionControllerRequestsPurchaseRestore:(MSSubscriptionsViewController *)controller {
    
}

#pragma mark Top toolbar delegate method

- (void)homeTopToolbar:(MSHomeTopToolbarView *)toolbar requestsFunctionality:(MSHomeTopToolbarViewFunctionality)functionality fromElement:(UIView *)element {
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
