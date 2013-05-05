//
//  MSMagazineBasicCell.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSMagazineBasicCell.h"
#import "MSBorderOverlayView.h"
#import "UILabel+DynamicHeight.h"
#import "SKProduct+Tools.h"
#import "MBProgressHUD.h"


@interface MSMagazineBasicCell ()

@property (nonatomic, strong) UIView *coverImageHighlight;
@property (nonatomic, strong) UIView *coverImageDownloadBcg;

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
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 18, 130, 190)];
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
    
    _coverImageDownloadBcg = [[UIView alloc] initWithFrame:_imageView.bounds];
    [_coverImageDownloadBcg setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
    [_coverImageDownloadBcg setAutoresizingWidthAndHeight];
    [_coverImageDownloadBcg setUserInteractionEnabled:YES];
    [_coverImageDownloadBcg setAlpha:0];
    [_coverImageDownloadBcg setHidden:YES];
    [_imageView addSubview:_coverImageDownloadBcg];
    
    _progressView = [[MBRoundProgressView alloc] init];
    [_progressView setAlpha:0];
    [_progressView setHidden:YES];
    [_imageView addSubview:_progressView];
    [_progressView centerInSuperview];
    [_progressView setAutoresizingCenter];
}

- (void)configureLabel:(UILabel *)label {
    [label setBackgroundColor:[UIColor clearColor]];
    [label setLineBreakMode:NSLineBreakByTruncatingTail];
}

- (void)createLabels {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_imageView.right + 10), 18, (self.width - (_imageView.right + 20)), 20)];
    [_titleLabel setTextColor:[UIColor colorWithHexString:kColorCellTitleLabel]];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self configureLabel:_titleLabel];
    [self addSubview:_titleLabel];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.xOrigin, (_titleLabel.bottom + 2), _titleLabel.width, 12)];
    [_dateLabel setTextColor:[UIColor colorWithHexString:kColorCellDateLabel]];
    [_dateLabel setFont:[UIFont boldSystemFontOfSize:10]];
    [self configureLabel:_dateLabel];
    [self addSubview:_dateLabel];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.xOrigin, (_dateLabel.bottom + 12), _titleLabel.width, 999)];
    [_infoLabel setTextColor:[UIColor colorWithHexString:kColorCellInfoLabel]];
    [_infoLabel setFont:[UIFont systemFontOfSize:11]];
    [_infoLabel setLineBreakMode:NSLineBreakByClipping];
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
    _actionButton = [MSCellActionButton buttonWithType:UIButtonTypeCustom];
    [_actionButton addTarget:self action:@selector(didClickActionsButton:) forControlEvents:UIControlEventTouchUpInside];
    [self configureButton:_actionButton];
    [_actionButton setFrame:CGRectMake(18, (self.height - 52), 90, 34)];
    [_actionButton setAutoresizingBottomLeft];
    [self addSubview:_actionButton];
}

- (void)createBackgroundView {
    _cellBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    [_cellBackgroundView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.1]];
    [_cellBackgroundView setAutoresizingWidthAndHeight];
    [self addSubview:_cellBackgroundView];
    
    if (kStyleCellBorderOverlayEnabled) {
        UIView *border = [[MSBorderOverlayView alloc] initWithFrame:_cellBackgroundView.bounds];
        [border setAutoresizingWidthAndHeight];
        [_cellBackgroundView addSubview:border];
    }
}

- (void)createAllElements {
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self createBackgroundView];
    [self createImageView];
    [self createButtons];
    [self createLabels];
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

- (void)showDownloadingIndicator:(BOOL)show {
    if (show) {
        if (_progressView.hidden == NO) return;
        [_progressView setAlpha:0];
        [_progressView setHidden:NO];
        [_coverImageDownloadBcg setAlpha:0];
        [_coverImageDownloadBcg setHidden:NO];
    }
    else if (_progressView.hidden == YES) return;
    [UIView animateWithDuration:0.3 animations:^{
        [_progressView setAlpha:(show ? 1 : 0)];
        [_coverImageDownloadBcg setAlpha:(show ? 1 : 0)];
    } completion:^(BOOL finished) {
        if (!show) {
            [_progressView setHidden:YES];
            [_coverImageDownloadBcg setHidden:YES];
        }
    }];
}

- (void)setIssueData:(MSProduct *)issueData {
    _issueData = issueData;
    
    [_titleLabel setText:issueData.name withWidth:_titleLabel.width];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *dateText = [formatter stringFromDate:issueData.date];
    [_dateLabel setText:dateText];
    [_infoLabel setText:issueData.info withWidth:_infoLabel.width];
    CGFloat h = (self.height - _infoLabel.yOrigin - 24 - _actionButton.height);
    if (_infoLabel.height > h) _infoLabel.height = h;
    
    [self layoutElements];
}


@end
