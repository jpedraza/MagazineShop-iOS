//
//  MSInAppPurchase.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 20/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kMSInAppPurchase                            [MSInAppPurchase purchaseObject]


@class MSInAppPurchase;

@protocol MSInAppPurchaseDelegate <NSObject>

- (void)inAppPurchase:(MSInAppPurchase *)purchase didFinishPurchase:(SKPayment *)payment;
- (void)inAppPurchase:(MSInAppPurchase *)purchase didRestorePurchases:(NSArray *)payments;
- (void)inAppPurchase:(MSInAppPurchase *)purchase failedToPurchase:(SKPayment *)payment withError:(NSError *)error;

@end


@interface MSInAppPurchase : NSObject <SKPaymentTransactionObserver>

@property (nonatomic, strong) id <MSInAppPurchaseDelegate> delegate;

+ (id)purchaseObject;

- (void)buyProduct:(SKProduct *)product;
- (void)restoreTransactions;


@end
