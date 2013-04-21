//
//  MSInAppPurchase.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 20/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSInAppPurchase.h"


@implementation MSInAppPurchase


#pragma mark Initialization

+ (id)purchaseObject {
    return [kAppDelegate inAppPurchase];
}

#pragma mark Purchasing

- (void)buyProduct:(SKProduct *)product {
    if ([SKPaymentQueue canMakePayments]) {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

- (void)restoreTransactions {
    if ([SKPaymentQueue canMakePayments]) {
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    }
}

#pragma mark Payment transactions delegate methods

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    //[self recordTransaction:transaction];
    if ([_delegate respondsToSelector:@selector(inAppPurchase:didFinishPurchase:)]) {
        [_delegate inAppPurchase:self didFinishPurchase:transaction.payment];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    //[self recordTransaction:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if (transaction.error.code != SKErrorPaymentCancelled) {
        if ([_delegate respondsToSelector:@selector(inAppPurchase:failedToPurchase:withError:)]) {
            [_delegate inAppPurchase:self failedToPurchase:transaction.payment withError:transaction.error];
        }
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    NSMutableArray *restored = [NSMutableArray array];
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                [restored addObject:transaction.payment];
            default:
                break;
        }
    }
    if ([restored count] > 0) {
        if ([_delegate respondsToSelector:@selector(inAppPurchase:didRestorePurchases:)]) {
            [_delegate inAppPurchase:self didRestorePurchases:restored];
        }
    }
}


@end
