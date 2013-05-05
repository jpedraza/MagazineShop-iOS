//
//  FT2PageView.m
//  MagazineShop
//
//  Created by Baldoph Pourprix on 13/12/2011.
//  Copyright (c) 2011 PublishTheMag.com. All rights reserved.
//

#import "MSLazyPageView.h"
#import "MSLazyReusableView.h"


@interface MSLazyPageView ()

@property (nonatomic) NSInteger _index;
@property (nonatomic) BOOL _usedAsContainer;
@property (nonatomic) NSInteger index;
@property (nonatomic) BOOL usedAsContainer;
@property (nonatomic, strong) UIView *containedView;

@end


@implementation MSLazyPageView


#pragma mark Initialization

- (id)initWithReuseIdentifier:(NSString *)identifier {
	self = [super initWithFrame:CGRectMake(0, 0, 320, 320)];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		_reuseIdentifier = identifier;
		
		_contentView = [[UIView alloc] initWithFrame:self.bounds];
		[_contentView setBackgroundColor:[UIColor clearColor]];
		[_contentView setAutoresizingWidthAndHeight];
		[self addSubview:_contentView];
	}
	return self;
}

#pragma mark Setters

- (void)setContainedView:(UIView *)containedView {
	[_containedView removeFromSuperview];
	_containedView = containedView;
	_containedView.frame = self.bounds;
	[self addSubview:containedView];
	[containedView centerInSuperview];
}

#pragma mark ReusableView Protocol

- (void)prepareForReuse {
	
}

- (void)willBeDiscarded {
	
}


@end
