//
//  UIColor+Tools.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 7.6.10.
//  Copyright 2010 PublishTheMag.com. All rights reserved.
//

#import "UIColor+Tools.h"
#import "UIImage+Tools.h"


#define DEFAULT_VOID_COLOR					[UIColor blackColor]


@implementation UIColor (Tools)

+ (CGFloat)getFrom:(CGFloat)value {
	//NSLog(@"From value:%f to: %f", value, (value / 255));
	return (value / 255.f);
}

+ (UIColor *)colorWithRealRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return [UIColor colorWithRed:[self getFrom:red] green:[self getFrom:green] blue:[self getFrom:blue] alpha:alpha];
}

- (UIColor *)colorWithRealRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return [UIColor colorWithRed:[UIColor getFrom:red] green:[UIColor getFrom:green] blue:[UIColor getFrom:blue] alpha:alpha];
}

+ (UIColor *)randomColor {
	CGFloat red =  (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {
	CGFloat red =  (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHexString: (NSString *)stringToConvert andAlpha:(CGFloat)alpha {
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return DEFAULT_VOID_COLOR;
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
	if ([cString length] != 6) return DEFAULT_VOID_COLOR;
	
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:alpha];
}

+ (UIColor *)colorWithHexString: (NSString *)stringToConvert {
    return [self colorWithHexString:stringToConvert andAlpha:1];
}

+ (UIColor *)alphaPatternImageColorWithSquareSide:(CGFloat)side withColor1:(UIColor *)color1 andColor2:(UIColor *)color2 {
	UIImage *patternImage = [UIImage alphaPatternImageWithSquareSide:side withColor1:color1 andColor2:color2];
	return [UIColor colorWithPatternImage:patternImage];
}

+ (UIColor *)alphaPatternImageColorWithSquareSide:(CGFloat)side {
	CGFloat c = 245;
	return [self alphaPatternImageColorWithSquareSide:side withColor1:[UIColor colorWithRealRed:c green:c blue:c alpha:1] andColor2:[UIColor whiteColor]];
}

+ (UIColor *)alphaPatternImageColor {
	return [self alphaPatternImageColorWithSquareSide:12];
}




@end
