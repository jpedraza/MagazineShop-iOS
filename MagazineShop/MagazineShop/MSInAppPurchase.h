//
//  MSInAppPurchase.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 20/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kMSInAppPurchase                            [MSInAppPurchase purchaseObject]


@class MSInAppPurchase, MSProduct;

@protocol MSInAppPurchaseDelegate <NSObject>

- (void)inAppPurchase:(MSInAppPurchase *)purchase didFinishPurchase:(SKPayment *)payment;
- (void)inAppPurchase:(MSInAppPurchase *)purchase didRestorePurchases:(NSArray *)payments;
- (void)inAppPurchase:(MSInAppPurchase *)purchase failedToPurchase:(SKPayment *)payment withError:(NSError *)error;
- (void)inAppPurchase:(MSInAppPurchase *)purchase userCanceledTransaction:(SKPayment *)payment;

@end


@interface MSInAppPurchase : NSObject <SKPaymentTransactionObserver>

@property (nonatomic, strong) id <MSInAppPurchaseDelegate> delegate;

+ (id)purchaseObject;

- (void)buyProduct:(SKProduct *)product;
- (void)restoreTransactions;
+ (BOOL)isProductPurchased:(MSProduct *)product;


@end
