//
//  MSMagezineDenseCell.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagezineDenseCell.h"
#import "UILabel+DynamicHeight.h"


@implementation MSMagezineDenseCell


#pragma mark Positioning

- (void)layoutElements {
    [self.imageView setSize:CGSizeMake(60, 80)];
    [self.titleLabel setFrame:CGRectMake(80, 10, (self.width - 80), 16)];
    [self.dateLabel setFrame:CGRectMake(80, (self.titleLabel.bottom + 2), self.titleLabel.width, 12)];
    [self.infoLabel setFrame:CGRectMake(10, (self.imageView.bottom + 10), (self.width - 20), 50)];
    [self.infoLabel fitToSuggestedHeight];
    if (self.infoLabel.height > 70) [self.infoLabel setHeight:70];
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
