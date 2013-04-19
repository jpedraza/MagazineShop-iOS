//
//  MSMagazineListView.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSView.h"


@class MSMagazineListView;

@protocol MSMagazineListViewDataSource <NSObject>

@end


@interface MSMagazineListView : MSView

@property (nonatomic, weak) id <MSMagazineListViewDataSource> dataSource;


@end
