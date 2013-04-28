//
//  MSMagazineReaderPageViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineReaderPageViewController.h"


@interface MSMagazineReaderPageViewController ()

@end


@implementation MSMagazineReaderPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
    _pageView = [[MSMagazineReaderBasicPageView alloc] initWithFrame:self.view.bounds];
    [_pageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_pageView];
}


@end
