//
//  MSMagazineMediumCell.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazineMediumCell.h"
#import "UILabel+DynamicHeight.h"


@implementation MSMagazineMediumCell


#pragma mark Positioning

- (void)layoutElements {
    if ([super isTablet]) {
        [self.infoLabel fitToSuggestedHeight];
        if (self.infoLabel.height > 70) [self.infoLabel setHeight:70];
        
        [self.dateLabel setFrame:CGRectMake(80, (self.titleLabel.bottom + 2), self.titleLabel.width, 12)];
    }
    else {
        [self.imageView setSize:CGSizeMake(60, 80)];
        
        [self.titleLabel setFrame:CGRectMake(18, (self.imageView.bottom + 6), (self.width - (2 * 18)), 16)];
        
        [self.dateLabel setFrame:CGRectMake(18, (self.titleLabel.bottom + 2), self.titleLabel.width, 12)];
        
        [self.infoLabel setHidden:YES];
        
        [self.actionButton setFrame:CGRectMake(18, (self.height - 18 - 30), (self.actionButton.width - 10), 30)];
        
        [self.detailButton setHidden:YES];
    }
}

#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
}

#pragma mark Settings

- (void)setIssueData:(MSProduct *)issueData {
    [super setIssueData:issueData];
    [self.imageView setImageUrlString:self.issueData.thumbnail withDefaultImage:[UIImage imageNamed:@"IconNS"] andCacheLifetime:MSImageViewCacheLifetimeForever];
}


@end
