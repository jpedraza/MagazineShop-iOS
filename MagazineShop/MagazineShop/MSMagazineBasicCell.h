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


@interface MSMagazineBasicCell : UICollectionViewCell

@property (nonatomic, strong) MSImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, strong) MSProduct *issueData;

- (void)createAllElements;
- (void)layoutElements;


@end
