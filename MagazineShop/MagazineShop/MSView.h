//
//  MSView.h
//  MagazineShop
//
//  Created by Ondrej Rafaj on 18/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MSView : UIView

- (void)createAllElements;

- (BOOL)isTablet;
- (BOOL)isBigPhone;
- (BOOL)isRetina;


@end
