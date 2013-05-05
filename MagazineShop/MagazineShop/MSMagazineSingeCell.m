//
//  MSMagazineSingeCell.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSMagazineSingeCell.h"
#import "UILabel+DynamicHeight.h"


@implementation MSMagazineSingeCell


#pragma mark Positioning

- (void)layoutElements {
    if ([self isTablet]) {
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
}


@end
