//
//  MSMagazineReaderFlatPageViewController.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSMagazineReaderViewControllerDataProtocol.h"


@interface MSMagazineReaderFlatPageViewController : UIViewController

@property (nonatomic, weak) id <MSMagazineReaderViewControllerDataProtocolDatasource> magazineDataSource;
@property (nonatomic, weak) id <MSMagazineReaderViewControllerDataProtocolDelegate> magazineDelegate;


@end
