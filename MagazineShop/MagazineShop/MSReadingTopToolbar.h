//
//  MSReadingTopToolbar.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 30/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSToolbarView.h"


@interface MSReadingTopToolbar : MSToolbarView

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeButton;

- (void)setTitle:(NSString *)title;


@end
