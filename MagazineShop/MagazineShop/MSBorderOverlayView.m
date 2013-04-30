//
//  MSBorderOverlayView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 20/02/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSBorderOverlayView.h"


@implementation MSBorderOverlayView


#pragma mark Creating elements

- (void)createAllElements {
    [self setUserInteractionEnabled:NO];
    [self setBackgroundColor:[UIColor clearColor]];
}

#pragma mark Draw rect

- (void)drawRect:(CGRect)rect {
    UIColor *strokeColor = [UIColor colorWithWhite:1 alpha:0.1];
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(10, 10, (self.width - 20), (self.height - 20)) byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii: CGSizeMake(14, 14)];
    [roundedRectanglePath closePath];
    [strokeColor setStroke];
    roundedRectanglePath.lineWidth = 1;
    CGFloat roundedRectanglePattern[] = {5, 5, 5, 5};
    [roundedRectanglePath setLineDash: roundedRectanglePattern count:4 phase:0];
    [roundedRectanglePath stroke];
}

#pragma mark Settings

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}


@end
