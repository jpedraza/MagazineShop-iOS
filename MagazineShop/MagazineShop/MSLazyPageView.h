//
//  FT2PageView.h
//  MagazineShop
//
//  Created by Baldoph Pourprix on 13/12/2011.
//  Copyright (c) 2011 PublishTheMag.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSLazyReusableView.h"


@interface MSLazyPageView : UIView <MSLazyReusableView>

- (id)initWithReuseIdentifier:(NSString *)identifier;

@property (nonatomic, strong, readonly) NSString *reuseIdentifier;
@property (nonatomic, strong) UIView *contentView;


@end
