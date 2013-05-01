//
//  MSSettingsViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 DoTheMag.com. All rights reserved.
//

#import "MSSettingsViewController.h"


@interface MSSettingsViewController ()

@property (nonatomic) CGFloat yPos;

@end


@implementation MSSettingsViewController


#pragma mark Creating elements

- (UILabel *)settingsLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, _yPos, 196, 26)];
    [label setText:text];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    [label setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:label];
    return label;
}

- (UISwitch *)settingsSwitch {
    UISwitch *sw = [[UISwitch alloc] init];
    [sw setOrigin:CGPointMake((300 - sw.width), _yPos)];
    [self.view addSubview:sw];
    return sw;
}

- (void)createReaderStyleSwitch {
    UISwitch *sw = [self settingsSwitch];
    [sw addTarget:self action:@selector(readerStyleSwitchDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    if ([MSConfig magazineDisplayMode] != MSConfigMagazineDisplayModeFlat) [sw setOn:YES];

    [self settingsLabelWithText:MSLangGet(@"Page curl style")];
}

- (void)createAllElements {
    [super createAllElements];
    
    _yPos = ([super isTablet] ? 20 : ([super isBigPhone] ? 460 : 400));
    
    if (![super isTablet]) [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    
    [self createReaderStyleSwitch];
}

#pragma mark Actions

- (void)readerStyleSwitchDidChangeValue:(UISwitch *)sender {
    [MSConfig setMagazineDisplayMode:(sender.isOn ? kStyleReadingCurlDefault : MSConfigMagazineDisplayModeFlat)];
}


@end
