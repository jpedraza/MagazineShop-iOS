//
//  MSSubscriptionsViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
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

- (void)configureSubscriptionButton:(UIButton *)b {
    [b.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [b.layer setBorderWidth:1];
    [b setBackgroundColor:[UIColor viewFlipsideBackgroundColor]];
    [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [b setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [b.titleLabel setShadowColor:[UIColor darkGrayColor]];
    [b.titleLabel setShadowOffset:CGSizeMake(1, 1)];
    [b.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
}

- (void)createSubscriptionButtons {
    if (!_subscriptionInfo) return;
    
    CGFloat yPos = 20;
    int x = 0;
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [self configureSubscriptionButton:b];
    [b addTarget:self action:@selector(didClickRenewPurchases:) forControlEvents:UIControlEventTouchUpInside];
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
        MSProduct *product = [[MSProduct alloc] init];
        [product fillDataFromDictionary:subscription];
        SKProduct *p = [_subscriptions objectForKey:[subscription objectForKey:@"identifier"]];
        [product setProduct:p];
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        [self configureSubscriptionButton:b];
        
        if ([MSInAppPurchase isProductPurchased:product]) {
            [b setEnabled:NO];
            [b setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        }
        
        [b addTarget:self action:@selector(didClickSubscriptionButton:) forControlEvents:UIControlEventTouchUpInside];
        [b setTag:x];
        float price = [[subscription objectForKey:@"price"] floatValue];
        
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
    if ([self isTablet]) if (yPos <= _scrollView.height) yPos = (_scrollView.height + 1);
    [_scrollView setContentSize:CGSizeMake(320, yPos)];
}

- (void)createAllElements {
    [super createAllElements];
    
    if (![super isTablet]) [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    
    CGFloat screenHeight = [super isTablet] ? 322 : self.view.height;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ([super isTablet] ? 0 : ([super isBigPhone] ? 220 : 220)), 320, screenHeight)];
    [self.view addSubview:_scrollView];
}

#pragma mark Actions

- (void)didClickRenewPurchases:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(subscriptionControllerRequestsPurchaseRestore:)]) {
        [_delegate subscriptionControllerRequestsPurchaseRestore:self];
    }
}

- (void)didClickSubscriptionButton:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(subscriptionController:requestsPurchaseForProduct:)]) {
        NSInteger index = sender.tag;
        SKProduct *product = [_subscriptions objectForKey:[[_subscriptionInfo objectAtIndex:index] objectForKey:@"identifier"]];
        [_delegate subscriptionController:self requestsPurchaseForProduct:product];
    }
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
    
    [super showHUDWithStyle:MBProgressHUDModeIndeterminate withTitle:MSLangGet(@"Loading subscriptions ...")];
    if (![super isTablet]) [self.progressHUD setYOffset:(self.progressHUD.yOffset + 40)];
    [NSThread detachNewThreadSelector:@selector(startLoadingData) toTarget:self withObject:nil];
}


@end
