//
//  MSSubscriptionsViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSSubscriptionsViewController.h"
#import "SKProduct+Tools.h"


@interface MSSubscriptionsViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableDictionary *subscriptions;
@property (nonatomic, strong) NSArray *subscriptionInfo;

@end


@implementation MSSubscriptionsViewController


#pragma mark Creating elements

- (void)createSubscriptionButtons {
    if (!_subscriptionInfo) return;
    
    CGFloat yPos = 20;
    
    int x = 0;
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b setTitle:MSLangGet(@"Renew purchases") forState:UIControlStateNormal];
    [b setFrame:CGRectMake(20, yPos, 280, 36)];
    [b setAlpha:0];
    [_scrollView addSubview:b];
    [UIView animateWithDuration:0.3 animations:^{
        [b setAlpha:1];
    }];
    yPos += 44;
    
    NSTimeInterval delay = 0.1;
    
    for (NSDictionary *subscription in _subscriptionInfo) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b setTag:x];
        float price = [[subscription objectForKey:@"price"] floatValue];
        SKProduct *p = [_subscriptions objectForKey:[subscription objectForKey:@"identifier"]];
        NSString *name = MSLangGet([subscription objectForKey:@"name"]);
        NSString *title = (price > 0) ? [NSString stringWithFormat:@"%@ (%@)", name, p.priceAsString] : name;
        [b setTitle:title forState:UIControlStateNormal];
        [b setFrame:CGRectMake(20, yPos, 280, 36)];
        [b setAlpha:0];
        [_scrollView addSubview:b];
        [UIView animateWithDuration:0.3 delay:delay options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [b setAlpha:1];
        } completion:^(BOOL finished) {
            
        }];
        delay += 0.1;
        yPos += 44;
        x++;
    }
    if (yPos <= _scrollView.height) yPos = (_scrollView.height + 1);
    [_scrollView setContentSize:CGSizeMake(320, yPos)];
}

- (void)createAllElements {
    [super createAllElements];
    
    CGFloat screenHeight = [super isTablet] ? 322 : self.view.height;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ([super isTablet] ? 0 : ([super isBigPhone] ? 300 : 260)), 320, screenHeight)];
    [self.view addSubview:_scrollView];
}

#pragma mark Actions

- (void)didClickSubscriptionButton {
    
}

#pragma mark Loading data

- (void)loadData {
    @autoreleasepool {
        NSString *url = [kMSConfigBaseUrl stringByAppendingPathComponent:@"api/subscriptions.json"];
        NSError *err;
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url] options:NSDataReadingUncached error:&err];
        if (!err) {
            NSDictionary *d = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
            _subscriptionInfo = [d objectForKey:@"subscriptions"];
            _subscriptions = [NSMutableDictionary dictionary];
            for (NSDictionary *s in _subscriptionInfo) {
                SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:[s objectForKey:@"identifier"]]];
                [request setDelegate:self];
                [request start];
            }
        }
    }
}

- (void)startLoadingData {
    @autoreleasepool {
        [self performSelectorInBackground:@selector(loadData) withObject:nil];
    }
}

#pragma mark StoreKit delegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    for (SKProduct *p in response.products) {
        [_subscriptions setObject:p forKey:p.productIdentifier];
    }
    if ([_subscriptionInfo count] == [[_subscriptions allKeys] count]) {
        [self performSelectorOnMainThread:@selector(createSubscriptionButtons) withObject:nil waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(hideHUD) withObject:nil waitUntilDone:NO];
    }
}

#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [super showHUDWithStyle:MBProgressHUDModeIndeterminate withTitle:MSLangGet(@"Loading subscriptions")];
    [NSThread detachNewThreadSelector:@selector(startLoadingData) toTarget:self withObject:nil];
}


@end
