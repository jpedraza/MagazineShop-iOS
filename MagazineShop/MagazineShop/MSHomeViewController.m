//
//  MSHomeViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSHomeViewController.h"
#import "MSMagazineReaderViewController.h"
#import "MSMagazineReaderData.h"


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
    [kMSInAppPurchase setDelegate:self];
    [super createAllElements];
    [self createToolbars];
    [self createMagazineView];
}

- (void)showSubscriptionsFromElement:(UIView *)element {
    if ([SKPaymentQueue canMakePayments]) {
        MSSubscriptionsViewController *c = [[MSSubscriptionsViewController alloc] init];
        [c setDelegate:self];
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
    [_magazineView setListViewType:type];
}

#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[[MSDataHolder sharedObject] products] count] == 0) [_magazineView loadProducts];
}

#pragma mark In app purchase delegate methods

- (void)inAppPurchase:(MSInAppPurchase *)purchase didFinishPurchase:(SKPayment *)payment {
    MSProduct *product = [[MSDataHolder sharedObject] productForIdentifier:payment.productIdentifier];
    [product setPurchaseStatus:MSProductPurchaseStatusPurchased];
    [_magazineView startDownloadingProductWithIdentifier:product.identifier];
    [_magazineView reloadData];
}

- (void)inAppPurchase:(MSInAppPurchase *)purchase didRestorePurchases:(NSArray *)payments {
    for (SKPayment *p in payments) {
        MSProduct *product = [[MSDataHolder sharedObject] productForIdentifier:p.productIdentifier];
        [product setPurchaseStatus:MSProductPurchaseStatusPurchased];
    }
    [_magazineView reloadData];
}

- (void)inAppPurchase:(MSInAppPurchase *)purchase failedToPurchase:(SKPayment *)payment withError:(NSError *)error {
    MSProduct *product = [[MSDataHolder sharedObject] productForIdentifier:payment.productIdentifier];
    [product setPurchaseStatus:MSProductPurchaseStatusNotPurchased];
    [_magazineView reloadData];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:MSLangGet(@"AppStore error") message:[error localizedDescription] delegate:nil cancelButtonTitle:MSLangGet(@"Ok") otherButtonTitles:nil];
    [alert show];
}

- (void)inAppPurchase:(MSInAppPurchase *)purchase userCanceledTransaction:(SKPayment *)payment {
    MSProduct *product = [[MSDataHolder sharedObject] productForIdentifier:payment.productIdentifier];
    [product setPurchaseStatus:MSProductPurchaseStatusNotPurchased];
    [_magazineView reloadData];
}

#pragma mark Magazine shop delegate & data source methods

- (void)magazineListView:(MSMagazineListView *)magazineView changedVisibilityStatus:(MSMagazineListViewVisibilityStatus)status {
    [_magazineView showNewMagazineView];
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

- (void)magazineView:(MSMagazineView *)view didRequestReaderForProduct:(MSProduct *)product {
    UIPageViewControllerTransitionStyle ts;
    NSDictionary *options = nil;
    if ([MSConfig magazineDisplayMode] == MSConfigMagazineDisplayModeFlat) {
        options = @{[NSNumber numberWithFloat:50.0f]: UIPageViewControllerOptionInterPageSpacingKey, [NSNumber numberWithInt:UIPageViewControllerSpineLocationMid]: UIPageViewControllerOptionSpineLocationKey};
        ts = UIPageViewControllerTransitionStyleScroll;
    }
    else {
        options = @{[NSNumber numberWithInt:UIPageViewControllerSpineLocationMid]: UIPageViewControllerOptionSpineLocationKey};
        ts = UIPageViewControllerTransitionStylePageCurl;
    }
    
   MSMagazineReaderViewController *c = [[MSMagazineReaderViewController alloc] initWithTransitionStyle:ts navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    MSMagazineReaderData *data = [[MSMagazineReaderData alloc] init];
    [data setViewController:c];
    [c setTitle:product.name];
    [data setProduct:product];
    [c setData:data];
    [c setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:c animated:YES completion:^{
        
    }];
}

#pragma mark Subscription controller delegate methods

- (void)subscriptionController:(MSSubscriptionsViewController *)controller requestsPurchaseForProduct:(SKProduct *)product {
    if ([super isTablet]) {
        [self.popover dismissPopoverAnimated:YES];
        [kMSInAppPurchase buyProduct:product];
    }
    else {
        [controller dismissViewControllerAnimated:YES completion:^{
            [kMSInAppPurchase buyProduct:product];
        }];
    }
}

- (void)subscriptionControllerRequestsPurchaseRestore:(MSSubscriptionsViewController *)controller {
    if ([super isTablet]) {
        [self.popover dismissPopoverAnimated:YES];
        [kMSInAppPurchase restoreTransactions];
    }
    else {
        [controller dismissViewControllerAnimated:YES completion:^{
            [kMSInAppPurchase restoreTransactions];
        }];
    }
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
