//
//  MSMagazineReaderBasicPageView.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import "MSView.h"


@interface MSMagazineReaderBasicPageView : MSView <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) NSInteger pageIndex;

- (void)setPageImage:(UIImage *)image;


@end
