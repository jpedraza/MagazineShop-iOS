//
//  MSMagazineMediumCell.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSMagazineMediumCell.h"
#import "UILabel+DynamicHeight.h"


@implementation MSMagazineMediumCell


#pragma mark Positioning

- (void)layoutElements {
    if ([super isTablet]) {
        [self.titleLabel setWidth:126];
        [self.titleLabel fitToSuggestedHeight];
        
        [self.dateLabel setFrame:CGRectMake(self.titleLabel.xOrigin, (self.titleLabel.bottom + 5), self.titleLabel.width, 12)];
        
        [self.infoLabel setYOrigin:(self.dateLabel.bottom + 15)];
        [self.infoLabel fitToSuggestedHeight];
        if (self.infoLabel.height > 70) [self.infoLabel setHeight:70];
     }
    else {
        [self.imageView setSize:CGSizeMake(60, 80)];
        [self.titleLabel setFrame:CGRectMake(18, (self.imageView.bottom + 6), (self.width - (2 * 18)), 16)];
        [self.dateLabel setFrame:CGRectMake(18, (self.titleLabel.bottom + 2), self.titleLabel.width, 12)];
        [self.infoLabel setHidden:YES];
        [self.actionButton setFrame:CGRectMake(18, (self.height - 18 - 30), (self.actionButton.width - 10), 30)];
    }
}

#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
}

#pragma mark Settings

- (void)setIssueData:(MSProduct *)issueData {
    [super setIssueData:issueData];
}


@end
