//
//  MSInAppPurchase.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 20/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSInAppPurchase.h"
#import "MSProduct.h"


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

- (void)recordTransaction:(SKPaymentTransaction *)transaction {
    NSString *identifierKey = [NSString stringWithFormat:@"iap-%@", transaction.payment.productIdentifier];
    BOOL isPurchased = (transaction.transactionState == SKPaymentTransactionStateRestored || transaction.transactionState == SKPaymentTransactionStatePurchased);
    [[NSUserDefaults standardUserDefaults] setBool:isPurchased forKey:identifierKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    if ([_delegate respondsToSelector:@selector(inAppPurchase:didFinishPurchase:)]) {
        [_delegate inAppPurchase:self didFinishPurchase:transaction.payment];
        [self recordTransaction:transaction];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    [self recordTransaction:transaction];
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

+ (BOOL)isProductPurchased:(MSProduct *)product {
    if (!product.product) return YES;
    return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"iap-%@", product.identifier]];
}


@end
