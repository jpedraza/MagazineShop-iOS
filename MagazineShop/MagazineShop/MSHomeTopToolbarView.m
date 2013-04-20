//
//  MSHomeTopToolbarView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSHomeTopToolbarView.h"


@interface MSHomeTopToolbarView ()

@property (nonatomic, strong) UIView *slidingSelectorView;

@end


@implementation MSHomeTopToolbarView


#pragma mark Layout

- (void)positionSlidingSelector:(BOOL)animated forButton:(UIButton *)sender {
    CGRect r = sender.frame;
    r.origin.x += 6;
    r.origin.y += 6;
    r.size.width -= 12;
    r.size.height -= 12;
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [_slidingSelectorView setFrame:r];
        }];
    }
    else {
        [_slidingSelectorView setFrame:r];
    }
}

#pragma mark Creating elements

- (void)createTitleLabel {
    if ([super isTablet]) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 10, 24)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor colorWithWhite:0.95 alpha:1]];
        [_titleLabel setShadowColor:[UIColor darkGrayColor]];
        [_titleLabel setShadowOffset:CGSizeMake(1, 1)];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_titleLabel setAutoresizingCenter];
        [self addSubview:_titleLabel];
    }
}

- (void)createButtons {
    CGFloat xPos = [super isTablet] ? 20 : 46;
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b addTarget:self action:@selector(didClickSubscriptionsButton:) forControlEvents:UIControlEventTouchUpInside];
    [b setFrame:CGRectMake(xPos, 5, 84, 34)];
    [b setTitle:MSLangGet(@"Subscriptions") forState:UIControlStateNormal];
    [b setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [b.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [self addSubview:b];
    
    
    xPos = [super isTablet] ? (self.width - 60) : 0;
    b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b addTarget:self action:@selector(didClickSettingsButton:) forControlEvents:UIControlEventTouchUpInside];
    [b setFrame:CGRectMake(xPos, 2, 40, 40)];
    [b setImage:[UIImage imageNamed:@"MS_icon_settings"] forState:UIControlStateNormal];
    [b setAutoresizingTopRight];
    [self addSubview:b];
    
    _slidingSelectorView = [[UIView alloc] init];
    [_slidingSelectorView setBackgroundColor:[UIColor colorWithHexString:@"00CAFF" andAlpha:1]];
    [_slidingSelectorView setClipsToBounds:YES];
    [_slidingSelectorView.layer setCornerRadius:3];
    [_slidingSelectorView setAutoresizingTopRight];
    [self addSubview:_slidingSelectorView];
    
    xPos = [super isTablet] ? (self.width - 120) : (self.width - 40);
    if ([super isTablet]) {
        b = [UIButton buttonWithType:UIButtonTypeCustom];
        [b addTarget:self action:@selector(didClickDenseListButton:) forControlEvents:UIControlEventTouchUpInside];
        [b setFrame:CGRectMake(xPos, 2, 40, 40)];
        [b setImage:[UIImage imageNamed:@"MS_icon_ninecolumn"] forState:UIControlStateNormal];
        [b setAutoresizingTopRight];
        [self addSubview:b];
        xPos -= 42;
    }
    
    b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b addTarget:self action:@selector(didClickListButton:) forControlEvents:UIControlEventTouchUpInside];
    [b setFrame:CGRectMake(xPos, 2, 40, 40)];
    [b setImage:[UIImage imageNamed:@"MS_icon_fourcolumn"] forState:UIControlStateNormal];
    [b setAutoresizingTopRight];
    [self addSubview:b];
    
    [self positionSlidingSelector:NO forButton:b];
    
    xPos -= 42;
    b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b addTarget:self action:@selector(didClickSingleButton:) forControlEvents:UIControlEventTouchUpInside];
    [b setFrame:CGRectMake(xPos, 2, 40, 40)];
    [b setImage:[UIImage imageNamed:@"MS_icon_onecolumn"] forState:UIControlStateNormal];
    [b setAutoresizingTopRight];
    [self addSubview:b];
}

- (void)createAllElements {
    [super createAllElements];
    
    [self setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth];
    CALayer *bottomBorder = [CALayer layer];
    [bottomBorder setFrame:CGRectMake(0, 43, self.width, 1)];
    [bottomBorder setBackgroundColor:[UIColor blackColor].CGColor];
    [self.layer addSublayer:bottomBorder];
    
    [self createTitleLabel];
    [self createButtons];
}

#pragma mark Settings

- (void)setTitle:(NSString *)title {
    [_titleLabel setText:title];
    [_titleLabel sizeToFit];
    [_titleLabel centerHorizontally];
}

#pragma mark Actions

- (void)requestFunctionality:(MSHomeTopToolbarViewFunctionality)functionality forSender:(UIView *)sender {
    if ([_delegate respondsToSelector:@selector(homeTopToolbar:requestsFunctionality:fromElement:)]) {
        [_delegate homeTopToolbar:self requestsFunctionality:functionality fromElement:sender];
    }
}

- (void)didClickSubscriptionsButton:(UIButton *)sender {
    [self requestFunctionality:MSHomeTopToolbarViewFunctionalitySubscriptions forSender:sender];
}

- (void)didClickSingleButton:(UIButton *)sender {
    [self requestFunctionality:MSHomeTopToolbarViewFunctionalitySingleView forSender:sender];
    [self positionSlidingSelector:YES forButton:sender];
}

- (void)didClickListButton:(UIButton *)sender {
    [self requestFunctionality:MSHomeTopToolbarViewFunctionalityListView forSender:sender];
    [self positionSlidingSelector:YES forButton:sender];
}

- (void)didClickDenseListButton:(UIButton *)sender {
    [self requestFunctionality:MSHomeTopToolbarViewFunctionalityDenseListView forSender:sender];
    [self positionSlidingSelector:YES forButton:sender];
}

- (void)didClickSettingsButton:(UIButton *)sender {
    [self requestFunctionality:MSHomeTopToolbarViewFunctionalitySettings forSender:sender];
}


@end
