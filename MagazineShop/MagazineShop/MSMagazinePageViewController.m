//
//  MSMagazinePageViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazinePageViewController.h"


@interface MSMagazinePageViewController ()

@end


@implementation MSMagazinePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
    _pageView = [[MSMagazineReaderBasicPageView alloc] initWithFrame:self.view.bounds];
    [_pageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_pageView];
    
    [_pageView setPageImage:[_product pageWithIndex:_pageIndex inSize:MSProductPageSize2048]];
}


@end
