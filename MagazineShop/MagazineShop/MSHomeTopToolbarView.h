//
//  MSHomeTopToolbarView.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSToolbarView.h"


@interface MSHomeTopToolbarView : MSToolbarView

@property (nonatomic, strong, readonly) UILabel *titleLabel;

- (void)setTitle:(NSString *)title;


@end
