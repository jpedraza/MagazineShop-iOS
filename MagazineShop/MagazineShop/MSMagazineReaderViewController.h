//
//  MSMagazineReaderCurledPageViewController.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSMagazineReaderViewControllerDataProtocol.h"
#import "MSMagazineReaderData.h"


@interface MSMagazineReaderViewController : UIPageViewController

@property (nonatomic, readonly) BOOL isLandscape;
@property (nonatomic, strong) MSMagazineReaderData *data;
@property (nonatomic, weak) id <MSMagazineReaderViewControllerDataProtocolDelegate> magazineDelegate;


@end
