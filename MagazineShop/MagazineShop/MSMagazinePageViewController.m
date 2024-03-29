//
//  MSMagazinePageViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSMagazinePageViewController.h"


@interface MSMagazinePageViewController ()

@end


@implementation MSMagazinePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
    _pageView = [[MSMagazineReaderBasicPageView alloc] initWithFrame:self.view.bounds];
    [_pageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [_pageView setPageIndex:_pageIndex];
    [self.view addSubview:_pageView];
    
    [_pageView setPageImage:[_product pageWithIndex:_pageIndex inSize:MSProductPageSizeSuperLarge]];
}


@end
