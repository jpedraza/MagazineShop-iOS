//
//  MSSubscriptionsViewController.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSViewController.h"


@class MSSubscriptionsViewController;

@protocol MSSubscriptionsViewControllerDelegate <NSObject>

- (void)subscriptionController:(MSSubscriptionsViewController *)controller requestsPurchaseForProduct:(SKProduct *)product;
- (void)subscriptionControllerRequestsPurchaseRestore:(MSSubscriptionsViewController *)controller;

@end


@interface MSSubscriptionsViewController : MSViewController <SKProductsRequestDelegate>

@property (nonatomic, weak) id <MSSubscriptionsViewControllerDelegate> delegate;


@end
