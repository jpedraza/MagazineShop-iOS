//
//  MSMagazineListSingleInvisibleScrollView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineListSingleInvisibleScrollView.h"


@implementation MSMagazineListSingleInvisibleScrollView


#pragma mark Passing through touch events

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    if (self.contentOffset.y < 0 && point.y < 0.0) {
//        return NO;
//    }
//    else {
//        return YES;
//    }
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //[super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //[super touchesEnded:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

    
@end
