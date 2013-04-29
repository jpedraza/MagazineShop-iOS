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

@property (nonatomic, strong) UIView *coverImageHighlight;

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
    [_imageView setUserInteractionEnabled:YES];
    [self addSubview:_imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCoverImage:)];
    [_imageView addGestureRecognizer:tap];
    
    _coverImageHighlight = [[UIView alloc] initWithFrame:_imageView.bounds];
    [_coverImageHighlight setBackgroundColor:[UIColor whiteColor]];
    [_coverImageHighlight setAutoresizingWidthAndHeight];
    [_coverImageHighlight setUserInteractionEnabled:NO];
    [_coverImageHighlight setAlpha:0];
    [_imageView addSubview:_coverImageHighlight];
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

- (void)configureButton:(UIButton *)b {
    [b.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [b.layer setBorderWidth:1];
    [b setBackgroundColor:[UIColor viewFlipsideBackgroundColor]];
    [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [b setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [b.titleLabel setShadowColor:[UIColor darkGrayColor]];
    [b.titleLabel setShadowOffset:CGSizeMake(1, 1)];
    [b.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
}

- (void)createButtons {
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_actionButton addTarget:self action:@selector(didClickActionsButton:) forControlEvents:UIControlEventTouchUpInside];
    [self configureButton:_actionButton];
    [_actionButton setFrame:CGRectMake(10, (self.height - 44), 90, 34)];
    [_actionButton setAutoresizingBottomLeft];
    [self addSubview:_actionButton];
    
    _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_detailButton addTarget:self action:@selector(didClickDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    [self configureButton:_detailButton];
    [_detailButton setTitle:MSLangGet(@"Detail") forState:UIControlStateNormal];
    [_detailButton setFrame:CGRectMake((_actionButton.right + 2), (self.height - 44), 60, 34)];
    [_detailButton setAutoresizingBottomLeft];
    [self addSubview:_detailButton];
}

- (void)createAllElements {
    [self setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    
    [self createImageView];
    [self createLabels];
    [self createButtons];
}

#pragma mark Actions

- (void)didClickActionsButton:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(magazineBasicCell:didRequestActionFor:)]) {
        [_delegate magazineBasicCell:self didRequestActionFor:_issueData];
    }
}

- (void)didClickDetailButton:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(magazineBasicCell:didRequestDetailFor:)]) {
        [_delegate magazineBasicCell:self didRequestDetailFor:_issueData];
    }
}

- (void)didTapCoverImage:(UITapGestureRecognizer *)recognizer {
    if ([_delegate respondsToSelector:@selector(magazineBasicCell:didRequestCoverFor:)]) {
        [_delegate magazineBasicCell:self didRequestCoverFor:_issueData];
    }
    [UIView animateWithDuration:0.15 animations:^{
        [_coverImageHighlight setAlpha:0.5];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            [_coverImageHighlight setAlpha:0];
        } completion:^(BOOL finished) {
            
        }];
    }];
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
    
    // TODO: Make sure this doesn't go after rotation if it's supposed to be disabled
    [_actionButton setEnabled:YES];
    
    NSString *actionTitle = MSLangGet(@"Buy");
    if ([MSInAppPurchase isProductPurchased:issueData]) {
        MSProductAvailability a = [issueData productAvailability];
        switch (a) {
            case MSProductAvailabilityNotPresent:
                actionTitle = MSLangGet(@"Download");
                break;
                
            case MSProductAvailabilityPartiallyDownloaded:
                actionTitle = MSLangGet(@"Preview");
                break;
                
            case MSProductAvailabilityDownloaded:
                actionTitle = MSLangGet(@"Read");
                break;
        }
    }
    [_actionButton setTitle:actionTitle forState:UIControlStateNormal];
    
    [self layoutElements];
}


@end
