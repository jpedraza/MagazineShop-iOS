//
//  MSMagezineDenseCell.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSMagezineDenseCell.h"
#import "UILabel+DynamicHeight.h"


@implementation MSMagezineDenseCell


#pragma mark Positioning

- (void)layoutElements {
    [self.imageView setSize:CGSizeMake(60, 80)];
    
    [self.titleLabel setFrame:CGRectMake(88, 18, (self.width - 98), 16)];
    [self.titleLabel fitToSuggestedHeight];
    if (self.titleLabel.height > 70) [self.titleLabel setHeight:70];
    
    [self.dateLabel setFrame:CGRectMake(88, (self.titleLabel.bottom + 2), self.titleLabel.width, 12)];
    
    [self.infoLabel setFrame:CGRectMake(18, (self.imageView.bottom + 6), (self.width - 38), 50)];
    [self.infoLabel fitToSuggestedHeight];
    if (self.infoLabel.height > 70) {
        [self.infoLabel setHeight:70];
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
