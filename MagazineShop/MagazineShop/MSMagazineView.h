//
//  MSMagazineView.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 20/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineListSingleView.h"
#import "MSMagazineListMediumView.h"
#import "MSMagazineListDenseView.h"
#import "MSDownload.h"
#import "MSMagazineBasicCell.h"


@class MSMagazineView;

@protocol MSMagazineViewDelegate <NSObject>

- (void)magazineViewDidStartLoadingData:(MSMagazineView *)view;
- (void)magazineViewDidFinishLoadingData:(MSMagazineView *)view;

@optional
- (void)magazineView:(MSMagazineView *)view didUpdatePercentageValue:(CGFloat)percentage;

@end


@interface MSMagazineView : MSView <MSMagazineListViewDataSource, SKProductsRequestDelegate, MSDownloadDelegate, MSMagazineBasicCellDelegate>

@property (nonatomic) MSConfigMainMagazineListViewType listViewType;
@property (nonatomic, weak) id <MSMagazineViewDelegate> delegate;

- (void)loadProducts;
- (void)reloadData;
- (void)setMagazineDelegate:(id <MSMagazineListViewDelegate>)delegate;
- (void)showNewMagazineView;


@end
