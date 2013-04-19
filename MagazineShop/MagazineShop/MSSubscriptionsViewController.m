//
//  MSSubscriptionsViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSSubscriptionsViewController.h"


@interface MSSubscriptionsViewController ()

@end


@implementation MSSubscriptionsViewController


#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
    
    CGFloat yPos = [super isTablet] ? 20 : ([super isBigPhone] ? 300 : 260);
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b setTitle:MSLangGet(@"Restore all purchases") forState:UIControlStateNormal];
    [b setFrame:CGRectMake(20, yPos, 280, 36)];
    [self.view addSubview:b];
    
    yPos += 44;
    b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b setTitle:MSLangGet(@"Restore all purchases") forState:UIControlStateNormal];
    [b setFrame:CGRectMake(20, yPos, 280, 36)];
    [self.view addSubview:b];
    
    yPos += 44;
    b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b setTitle:MSLangGet(@"Restore all purchases") forState:UIControlStateNormal];
    [b setFrame:CGRectMake(20, yPos, 280, 36)];
    [self.view addSubview:b];
    
    yPos += 44;
    b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b setTitle:MSLangGet(@"Restore all purchases") forState:UIControlStateNormal];
    [b setFrame:CGRectMake(20, yPos, 280, 36)];
    [self.view addSubview:b];
}


@end
