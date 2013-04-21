//
//  MSSettingsViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSSettingsViewController.h"


@interface MSSettingsViewController ()

@end


@implementation MSSettingsViewController


#pragma mark Creating elements

- (void)createAllElements {
    [super createAllElements];
    
    if (![super isTablet]) [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
}


@end
