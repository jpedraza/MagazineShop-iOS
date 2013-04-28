//
//  MSMagazineBasicCell.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineBasicCell.h"


@interface MSMagazineBasicCell ()

@end


@implementation MSMagazineBasicCell


#pragma mark Positioning

- (void)layoutElements {
    
}

#pragma mark Creating elements

- (void)createImageView {
    _imageView = [[MSImageView alloc] initWithFrame:CGRectMake(10, 10, 130, 190)];
    [_imageView setBackgroundColor:[UIColor randomColor]];
    [self addSubview:_imageView];
}

- (void)createLabels {
    
}

- (void)createButtons {
    
}

- (void)createAllElements {
    [self setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    
    [self createImageView];
    [self createLabels];
    [self createButtons];
    
    
}

#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createAllElements];
    }
    return self;
}

#pragma mark Settings

- (void)setIssueData:(MSProduct *)issueData {
    _issueData = issueData;
    
    [_titleLabel setText:issueData.name];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [_dateLabel setText:[formatter stringFromDate:issueData.date]];
    [_infoLabel setText:issueData.info];
}


@end
