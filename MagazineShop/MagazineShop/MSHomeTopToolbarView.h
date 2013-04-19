//
//  MSHomeTopToolbarView.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSToolbarView.h"


typedef enum {
    MSHomeTopToolbarViewFunctionalitySubscriptions,
    MSHomeTopToolbarViewFunctionalitySettings,
    MSHomeTopToolbarViewFunctionalitySingleView,
    MSHomeTopToolbarViewFunctionalityListView,
    MSHomeTopToolbarViewFunctionalityDenseListView
} MSHomeTopToolbarViewFunctionality;


@class MSHomeTopToolbarView;

@protocol MSHomeTopToolbarViewDelegate <NSObject>

- (void)homeTopToolbar:(MSHomeTopToolbarView *)toolbar requestsFunctionality:(MSHomeTopToolbarViewFunctionality)functionality fromElement:(UIView *)element;

@end


@interface MSHomeTopToolbarView : MSToolbarView

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, weak) id <MSHomeTopToolbarViewDelegate> delegate;

- (void)setTitle:(NSString *)title;


@end
