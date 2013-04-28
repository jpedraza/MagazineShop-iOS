//
//  MSLabel.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 28/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSLabel.h"


@implementation MSLabel


#pragma mark Settings

- (void)setUnderline:(BOOL)underline {
    _underline = underline;
    [self setNeedsDisplay];
}

- (void)setFullUnderline:(BOOL)fullUnderline {
    _fullUnderline = fullUnderline;
    [self setNeedsDisplay];
}

#pragma mark Draw rect

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
}

#pragma mark Initialization

- (void)setupView {
    [self setBackgroundColor:[UIColor clearColor]];
    if (kDebug) {
        [self setBackgroundColor:[UIColor randomColor]];
    }
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


@end
