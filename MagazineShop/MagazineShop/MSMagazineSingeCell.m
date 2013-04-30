//
//  MSMagazineSingeCell.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazineSingeCell.h"
#import "UILabel+DynamicHeight.h"


@implementation MSMagazineSingeCell


#pragma mark Positioning

- (void)layoutElements {
    if ([self isTablet]) {
//        [self.imageView setYOrigin:0];
        [self.imageView setSize:CGSizeMake(332, 485)];
        
        [self.titleLabel setFrame:CGRectMake((self.imageView.right + 30), 18, (self.width - (self.imageView.right + 50 + 18)), 20)];
        [self.titleLabel fitToSuggestedHeight];
        
        [self.dateLabel setOrigin:CGPointMake(self.titleLabel.xOrigin, (self.titleLabel.bottom + 3))];
        [self.dateLabel setWidth:self.titleLabel.width];
        
        [self.infoLabel setXOrigin:self.titleLabel.xOrigin];
        [self.infoLabel setWidth:self.titleLabel.width];
        [self.infoLabel fitToSuggestedHeight];
        
        [self.actionButton setXOrigin:self.titleLabel.xOrigin];
        [self.actionButton setYOrigin:(self.infoLabel.bottom + 30)];
        
        [self.detailButton setXOrigin:(self.actionButton.right + 12)];
        [self.detailButton setYOrigin:self.actionButton.yOrigin];
        
//        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//        rotationAndPerspectiveTransform.m34 = 1.0 / -1500.0;
//        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI * 0.15, 0.2f, 0.1f, -0.1f);
//        [self.imageView.layer setTransform:rotationAndPerspectiveTransform];
//        
//        [self.imageView.layer setZPosition:200];
    }
    else {
        [self.titleLabel fitToSuggestedHeight];
        
        [self.dateLabel setOrigin:CGPointMake(self.titleLabel.xOrigin, (self.titleLabel.bottom + 3))];
        
        [self.infoLabel setOrigin:CGPointMake(self.titleLabel.xOrigin, (self.dateLabel.bottom + 10))];
        if (self.infoLabel.height > 200) [self.infoLabel setHeight:200];
    }
}

#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
    
    [self.actionButton setExclusiveTouch:YES];
}

#pragma mark Settings

- (void)setIssueData:(MSProduct *)issueData {
    [super setIssueData:issueData];
    [self.imageView setImageUrlString:self.issueData.cover withDefaultImage:[UIImage imageNamed:@"IconNS"] andCacheLifetime:MSImageViewCacheLifetimeForever];
}


@end
