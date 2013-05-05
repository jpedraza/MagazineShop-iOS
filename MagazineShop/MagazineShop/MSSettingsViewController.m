//
//  MSSettingsViewController.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 19/04/2013.
//  Copyright (c) 2013 PublishTheMag.com. All rights reserved.
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
    [sw setOnTintColor:[UIColor darkGrayColor]];
    [sw setOrigin:CGPointMake((300 - sw.width), _yPos)];
    [self.view addSubview:sw];
    return sw;
}

- (void)insertLine {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(20, (_yPos - 8), 280, 1)];
    [v setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.05]];
    [self.view addSubview:v];
}

- (void)createReaderStyleSwitch {
    UISwitch *sw = [self settingsSwitch];
    [sw addTarget:self action:@selector(readerStyleSwitchDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    if ([MSConfig magazineDisplayMode] != MSConfigMagazineDisplayModeFlat) [sw setOn:YES];
    [self settingsLabelWithText:MSLangGet(@"Page curl style")];
    
    _yPos += 45;
}

- (void)createScrollableInLandscapeSwitch {
    UISwitch *sw = [self settingsSwitch];
    [sw addTarget:self action:@selector(readerScrollableInLandscapeSwitchDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    [sw setOn:[MSConfig scrollInLandscapeMode]];
    
    [self settingsLabelWithText:MSLangGet(@"Scroll page in landscape")];
    
    _yPos += 45;
}

- (void)createBackgroundColorSwitch {
    UISwitch *sw = [self settingsSwitch];
    [sw setOnTintColor:[UIColor blackColor]];
    [sw setOnImage:[UIImage imageNamed:@"MS_ico_black"]];
    [sw setOffImage:[UIImage imageNamed:@"MS_ico_white"]];
    [sw addTarget:self action:@selector(readerBackgroundColorSwitchDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    [sw setOn:[MSConfig readerBackgroundColorIsBlack]];
    
    [self settingsLabelWithText:MSLangGet(@"Reader background color")];
    
    _yPos += 45;
}

- (void)createAllElements {
    [super createAllElements];
    
    _yPos = ([super isTablet] ? 20 : ([super isBigPhone] ? 360 : 300));
    
    if (![super isTablet]) [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    
    [self createReaderStyleSwitch];
    [self insertLine];
    [self createScrollableInLandscapeSwitch];
    [self insertLine];
    [self createBackgroundColorSwitch];
}

#pragma mark Actions

- (void)readerStyleSwitchDidChangeValue:(UISwitch *)sender {
    [MSConfig setMagazineDisplayMode:(sender.isOn ? kStyleReadingCurlDefault : MSConfigMagazineDisplayModeFlat)];
}

- (void)readerScrollableInLandscapeSwitchDidChangeValue:(UISwitch *)sender {
    [MSConfig setScrollInLandscapeMode:sender.isOn];
}

- (void)readerBackgroundColorSwitchDidChangeValue:(UISwitch *)sender {
    [MSConfig setReaderBackgroundColorIsBlack:sender.isOn];
}


@end
