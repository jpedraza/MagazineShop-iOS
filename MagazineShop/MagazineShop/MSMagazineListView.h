//
//  MSMagazineListView.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSView.h"


typedef enum {
    MSMagazineListViewVisibilityStatusVisible,
    MSMagazineListViewVisibilityStatusHidden
} MSMagazineListViewVisibilityStatus;


@class MSMagazineListView;

@protocol MSMagazineListViewDataSource <NSObject>

@end


@protocol MSMagazineListViewDelegate <NSObject>

- (void)magazineListView:(MSMagazineListView *)magazineView changedVisibilityStatus:(MSMagazineListViewVisibilityStatus)status;

@end


@interface MSMagazineListView : MSView

@property (nonatomic, weak) id <MSMagazineListViewDataSource> dataSource;
@property (nonatomic, weak) id <MSMagazineListViewDelegate> delegate;

- (void)show;
- (void)hide;


@end
