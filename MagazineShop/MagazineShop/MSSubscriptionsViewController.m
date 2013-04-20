//
//  MSSubscriptionsViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSSubscriptionsViewController.h"


@interface MSSubscriptionsViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end


@implementation MSSubscriptionsViewController


#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
    
    CGFloat screenHeight = [super isTablet] ? 360 : self.view.height;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ([super isTablet] ? 0 : ([super isBigPhone] ? 300 : 260)), 320, screenHeight)];
    [self.view addSubview:_scrollView];
    
    CGFloat yPos = 20;
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b setTitle:MSLangGet(@"Restore all purchases") forState:UIControlStateNormal];
    [b setFrame:CGRectMake(20, yPos, 280, 36)];
    [_scrollView addSubview:b];
    
    yPos += 44;
    b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b setTitle:MSLangGet(@"Restore all purchases") forState:UIControlStateNormal];
    [b setFrame:CGRectMake(20, yPos, 280, 36)];
    [_scrollView addSubview:b];
    
    yPos += 44;
    b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b setTitle:MSLangGet(@"Restore all purchases") forState:UIControlStateNormal];
    [b setFrame:CGRectMake(20, yPos, 280, 36)];
    [_scrollView addSubview:b];
    
    yPos += 44;
    b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b setTitle:MSLangGet(@"Restore all purchases") forState:UIControlStateNormal];
    [b setFrame:CGRectMake(20, yPos, 280, 36)];
    [_scrollView addSubview:b];
    
    yPos += 44;
    [_scrollView setContentSize:CGSizeMake(320, 600)];
}


@end
