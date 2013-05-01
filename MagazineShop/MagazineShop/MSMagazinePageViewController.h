//
//  MSMagazinePageViewController.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSViewController.h"
#import "MSMagazineReaderBasicPageView.h"


@interface MSMagazinePageViewController : MSViewController

@property (nonatomic, strong) MSMagazineReaderBasicPageView *pageView;
@property (nonatomic, strong) MSProduct *product;
@property (nonatomic) NSInteger pageIndex;


@end
