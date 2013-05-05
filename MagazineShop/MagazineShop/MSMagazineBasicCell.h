//
//  MSMagazineBasicCell.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSCellActionButton.h"


@class MSMagazineBasicCell, MBRoundProgressView;

@protocol MSMagazineBasicCellDelegate <NSObject>

- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestActionFor:(MSProduct *)product;
- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestDetailFor:(MSProduct *)product;
- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestCoverFor:(MSProduct *)product;

@end


@interface MSMagazineBasicCell : UICollectionViewCell

@property (nonatomic, strong) UIView *cellBackgroundView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) MSCellActionButton *actionButton;
@property (nonatomic, strong) MBRoundProgressView *progressView;

@property (nonatomic, strong) MSProduct *issueData;

@property (nonatomic, weak) id <MSMagazineBasicCellDelegate> delegate;

- (void)createAllElements;
- (void)layoutElements;

- (BOOL)isTablet;
- (BOOL)isBigPhone;
- (BOOL)isRetina;

- (void)showDownloadingIndicator:(BOOL)show;


@end
