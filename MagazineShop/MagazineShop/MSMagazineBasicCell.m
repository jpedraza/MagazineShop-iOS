//
//  MSMagazineBasicCell.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineBasicCell.h"
#import "UILabel+DynamicHeight.h"


@interface MSMagazineBasicCell ()

@end


@implementation MSMagazineBasicCell


#pragma mark Environment

- (BOOL)isTablet {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

- (BOOL)isBigPhone {
    return ([[UIScreen mainScreen] bounds].size.height == 568);
}

- (BOOL)isRetina {
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0));
}

#pragma mark Positioning

- (void)layoutElements {
    [_dateLabel setYOrigin:(_titleLabel.bottom + 3)];
    [_infoLabel setYOrigin:(_dateLabel.bottom + 6)];
}

#pragma mark Creating elements

- (void)createImageView {
    _imageView = [[MSImageView alloc] initWithFrame:CGRectMake(10, 10, 130, 190)];
    [_imageView setBackgroundColor:[UIColor randomColor]];
    [self addSubview:_imageView];
}

- (void)configureLabel:(UILabel *)label {
    [label setBackgroundColor:[UIColor clearColor]];
    [label setLineBreakMode:NSLineBreakByTruncatingTail];
}

- (void)createLabels {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_imageView.right + 10), 10, (self.width - (_imageView.right + 20)), 20)];
    [_titleLabel setTextColor:[UIColor colorWithHexString:kColorCellTitleLabel]];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self configureLabel:_titleLabel];
    [self addSubview:_titleLabel];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.xOrigin, (_titleLabel.bottom + 2), _titleLabel.width, 12)];
    [_titleLabel setTextColor:[UIColor colorWithHexString:kColorCellDateLabel]];
    [_dateLabel setFont:[UIFont boldSystemFontOfSize:10]];
    [self configureLabel:_dateLabel];
    [self addSubview:_dateLabel];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.xOrigin, (_dateLabel.bottom + 2), _titleLabel.width, 999)];
    [_titleLabel setTextColor:[UIColor colorWithHexString:kColorCellInfoLabel]];
    [_infoLabel setFont:[UIFont boldSystemFontOfSize:11]];
    [self configureLabel:_infoLabel];
    [self addSubview:_infoLabel];
}

- (void)createButtons {
    _actionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_actionButton setTitle:@"Action" forState:UIControlStateNormal];
    [_actionButton setFrame:CGRectMake(10, (self.height - 44), 100, 34)];
    [_actionButton setAutoresizingBottomLeft];
    [self addSubview:_actionButton];
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
    
    [_titleLabel setText:issueData.name withWidth:_titleLabel.width];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *dateText = [formatter stringFromDate:issueData.date];
    [_dateLabel setText:dateText];
    [_infoLabel setText:issueData.info withWidth:_infoLabel.width];
    
    [self layoutElements];
}


@end
