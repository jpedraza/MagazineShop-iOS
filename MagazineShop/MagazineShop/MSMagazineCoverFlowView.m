//
//  MSMagazineCoverFlowView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 03/05/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSMagazineCoverFlowView.h"


@implementation MSMagazineCoverFlowView


#pragma mark Creating elements

- (void)createAllElements {
    self.disableCollectionView = YES;
    [super createAllElements];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    [v setBackgroundColor:[UIColor redColor]];
    [self addSubview:v];
}


@end
