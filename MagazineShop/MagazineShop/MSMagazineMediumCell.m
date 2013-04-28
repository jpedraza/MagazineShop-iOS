//
//  MSMagazineMediumCell.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineMediumCell.h"


@implementation MSMagazineMediumCell


#pragma mark Positioning

- (void)layoutElements {
    
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
