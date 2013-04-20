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


@class MSMagazineView;

@protocol MSMagazineViewDelegate <NSObject>

@optional
- (void)magazineViewDidStartLoadingData:(MSMagazineView *)view;
- (void)magazineViewDidFinishLoadingData:(MSMagazineView *)view;

@end


@interface MSMagazineView : MSView <MSMagazineListViewDataSource>

@property (nonatomic, weak) id <MSMagazineViewDelegate> delegate;

- (void)loadProducts;
- (void)setMagazineDelegate:(id <MSMagazineListViewDelegate>)delegate;


@end
