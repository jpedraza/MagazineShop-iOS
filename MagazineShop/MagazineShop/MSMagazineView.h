//
//  MSMagazineView.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 20/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazineListSingleView.h"
#import "MSMagazineListMediumView.h"
#import "MSMagazineListDenseView.h"
#import "MSDownload.h"
#import "MSMagazineBasicCell.h"


@class MSMagazineView;

@protocol MSMagazineViewDelegate <NSObject>

@required
- (void)magazineViewDidStartLoadingData:(MSMagazineView *)view;
- (void)magazineViewDidFinishLoadingData:(MSMagazineView *)view;
- (void)magazineView:(MSMagazineView *)view didRequestReaderForProduct:(MSProduct *)product;

@optional
- (void)magazineView:(MSMagazineView *)view didUpdatePercentageValue:(CGFloat)percentage;

@end


@interface MSMagazineView : MSView <MSMagazineListViewDataSource, SKProductsRequestDelegate, MSDownloadDelegate, MSMagazineBasicCellDelegate, MSProductDelegate>

@property (nonatomic) MSConfigMainMagazineListViewType listViewType;
@property (nonatomic, weak) id <MSMagazineViewDelegate> delegate;

- (void)loadProducts;
- (void)reloadData;
- (void)setMagazineDelegate:(id <MSMagazineListViewDelegate>)delegate;
- (void)showNewMagazineView;


@end
