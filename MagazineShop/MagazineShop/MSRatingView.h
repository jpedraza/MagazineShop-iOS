//
//  RateView.h
//  CustomView
//
//  Created by Ray Wenderlich on 7/30/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSRatingView;

@protocol MSRatingViewDelegate
- (void)ratingView:(MSRatingView *)ratingView ratingDidChange:(float)rating;
@end

@interface MSRatingView : UIView {
    NSMutableArray *imageViews;
}

@property (nonatomic, strong) UIImage *notSelectedImage;
@property (nonatomic, strong) UIImage *halfSelectedImage;
@property (nonatomic, strong) UIImage *fullSelectedImage;
@property (nonatomic) float rating;
@property  BOOL editable;
@property (nonatomic, assign) id <MSRatingViewDelegate> delegate;

@end