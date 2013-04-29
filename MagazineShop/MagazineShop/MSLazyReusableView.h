//
//  FT2ReusableView.h
//  MagazineShop
//
//  Created by Baldoph Pourprix on 14/12/2011.
//  Copyright (c) 2011 Fuerte Innovations. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Protocol notably used by MSLazyPageScrollView for views returned by the data source that are not 
 * FT2PageView objects  */

@protocol MSLazyReusableView <NSObject>

@optional

- (void)prepareForReuse;
- (void)willBeDiscarded;


@end
