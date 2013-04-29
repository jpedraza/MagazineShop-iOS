//
//  MSMagazineBasicCell.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 21/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSImageView.h"
#import "MSProduct.h"


@class MSMagazineBasicCell;

@protocol MSMagazineBasicCellDelegate <NSObject>

- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestActionFor:(MSProduct *)product;
- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestDetailFor:(MSProduct *)product;
- (void)magazineBasicCell:(MSMagazineBasicCell *)cell didRequestCoverFor:(MSProduct *)product;

@end


@interface MSMagazineBasicCell : UICollectionViewCell

@property (nonatomic, strong) MSImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIButton *detailButton;

@property (nonatomic, strong) MSProduct *issueData;

@property (nonatomic, weak) id <MSMagazineBasicCellDelegate> delegate;

- (void)createAllElements;
- (void)layoutElements;

- (BOOL)isTablet;
- (BOOL)isBigPhone;
- (BOOL)isRetina;


@end
