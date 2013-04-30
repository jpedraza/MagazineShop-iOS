//
//  MSHomeViewController.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSSettingsViewController.h"
#import "MSSubscriptionsViewController.h"
#import "MSInfoViewController.h"
#import "MSHomeTopToolbarView.h"
#import "MSHomeBottomToolbarView.h"
#import "MSMagazineView.h"


@interface MSHomeViewController : MSViewController <MSHomeTopToolbarViewDelegate, MSMagazineListViewDelegate, MSMagazineViewDelegate, MSSubscriptionsViewControllerDelegate, MSInAppPurchaseDelegate>

@end
