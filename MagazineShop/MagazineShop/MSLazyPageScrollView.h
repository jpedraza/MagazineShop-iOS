//
//  MSLazyPageScrollView.h
//  MagazineShop
//
//  Created by Baldoph Pourprix on 16/11/2011.
//  Copyright (c) 2011 DoTheMag.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 - reuse of views like UITableView
 - horizontal content
 */


typedef enum {
	MSLazyPageScrollViewFlowHorizontal,
	MSLazyPageScrollViewFlowVertical
} MSLazyPageScrollViewFlow;


@class MSLazyPageScrollView, MSLazyPageView;

@protocol MSLazyPageScrollViewDataSource <NSObject>

@required
- (NSInteger)numberOfPagesInPageScrollView:(MSLazyPageScrollView *)scrollView;

@optional
//only one of the 3 following methods is required
//display an image
- (UIImage *)pageScrollView:(MSLazyPageScrollView *)scrollView imageForPageAtIndex:(NSInteger)index;
//simple reusing: the property reusedView contained a reused view of the same class of the one you returned before
- (UIView *)pageScrollView:(MSLazyPageScrollView *)scrollView viewForPageAtIndex:(NSInteger)index reusedView:(UIView *)view;
//cells queuing and reuse - table view like
- (MSLazyPageView *)pageScrollView:(MSLazyPageScrollView *)scrollView pageViewAtIndex:(NSInteger)index;

@end


@protocol MSLazyPageScrollViewDelegate <NSObject, UIScrollViewDelegate>

@optional
//the view at index 'index' received a touch
- (void)pageScrollView:(MSLazyPageScrollView *)scrollView didSelectViewAtIndex:(NSInteger)index;
- (void)pageScrollView:(MSLazyPageScrollView *)scrollView didSelectPageAtIndex:(NSInteger)index;

- (void)pageScrollView:(MSLazyPageScrollView *)scrollView didSlideToIndex:(NSInteger)index;

- (void)pageScrollView:(MSLazyPageScrollView *)scrollView willDiscardView:(UIView *)view;
- (void)pageScrollView:(MSLazyPageScrollView *)scrollView willDiscardPage:(MSLazyPageView *)page;

- (void)pageScrollViewCanBeRotated:(MSLazyPageScrollView *)scrollView;

//if you provide this method to your delegate, page scroll view will let it
//ensure the queuing of pages. Useful if several instances of page scroll views 
//are using the same pages and you want to do a general caching of those pages.
//Therefore -dequeuePageForIdentifer: will always return nil
- (void)pageScrollView:(MSLazyPageScrollView *)scrollView enqueuePage:(MSLazyPageView *)pageView;

@end


@interface MSLazyPageScrollView : UIScrollView {
	
	NSMutableSet *_visibleViews;
	NSMutableSet *_reusableViews;
	NSMutableDictionary *_reusablePages;
	
	NSInteger _numberOfPages;
	CGRect _varianceRect;
	
	CGFloat _visiblePadding;
	__weak id <MSLazyPageScrollViewDelegate> _pageScrollViewDelegate;
	
	MSLazyPageScrollViewFlow _flow;
	
	BOOL _didUpdateFrame;
	
	struct {
        unsigned int dataSourceImagesOnly:1;
        unsigned int dataSourceViewsOnly:1;
		unsigned int dataSourcePagesOnly:1;
		unsigned int delegateDidSelectView:1;
		unsigned int delegateDidSelectPage:1;
		unsigned int delegateDidSlideToIndex:1;
		unsigned int delegateWillDiscardView:1;
		unsigned int delegateWillDiscardPage:1;
		unsigned int delegateCanBeRotated:1;
		unsigned int delegateEnsureQueuing:1;
    } _pageScrollViewFlags;
}

@property (nonatomic, weak) id <MSLazyPageScrollViewDataSource> dataSource;
@property (nonatomic, weak) id <MSLazyPageScrollViewDelegate> delegate;
@property (nonatomic) CGSize visibleSize;
//use page size to define width of pages when paging is disabled
@property (nonatomic) CGSize pageSize;
@property (nonatomic, readonly) MSLazyPageScrollViewFlow flow;

- (id)initWithFrame:(CGRect)frame contentFlow:(MSLazyPageScrollViewFlow)flow;

- (BOOL)canBeRotated;

- (void)reloadData;
- (void)reloadPageNumber; //doesn't reload content but change the contentSize accordingly

- (void)scrollToPageAtIndex:(NSInteger)index animated:(BOOL)animated;

- (id)dequeuePageForIdentifer:(NSString *)identifier;

- (NSInteger)selectedIndex;

- (UIView *)selectedView;
- (MSLazyPageView *)selectedPage;

- (NSInteger)indexOfView:(UIView *)view;
- (NSInteger)indexOfPage:(MSLazyPageView *)view;

- (UIView *)viewAtIndex:(NSUInteger)index;
- (MSLazyPageView *)pageAtIndex:(NSUInteger)index;

- (NSArray *)visibleViews;
- (NSArray *)visiblePages;


@end
