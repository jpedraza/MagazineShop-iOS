//
//  MSMagazineView.m
//  MagazineShop
//
//  Created by Ondrej Rafaj on 20/04/2013.
//  Copyright (c) 2013 Fuerte Innovations. All rights reserved.
//

#import "MSMagazineView.h"


@interface MSMagazineView ()

@property (nonatomic, strong) MSMagazineListSingleView *magazineSingleView;
@property (nonatomic, strong) MSMagazineListMediumView *magazineListView;
@property (nonatomic, strong) MSMagazineListDenseView *magazineDenseView;

@property (nonatomic, strong) MSMagazineListView *currentMagazineView;

@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) NSArray *productsInfo;

@property (nonatomic, strong) id <MSMagazineListViewDelegate> magazineDelegate;

@end


@implementation MSMagazineView


#pragma mark Creating elements

- (void)createMagazineSingleView {
    
}

- (void)createMagazineListView {
    _magazineListView = [[MSMagazineListMediumView alloc] initWithFrame:self.bounds];
    [_magazineListView setAutoresizingWidthAndHeight];
    [_magazineListView setDataSource:self];
    [_magazineListView setDelegate:_magazineDelegate];
    [self addSubview:_magazineListView];
    _currentMagazineView = _magazineListView;
}

- (void)createMagazineDenseView {
    
}

- (void)createAllElements {
    [self setBackgroundColor:[UIColor randomColor]];
    
    [super createAllElements];
    [self createMagazineListView];
}

#pragma mark Settings

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    NSLog(@"Magazine view: %@", NSStringFromCGRect(self.frame));
}

- (void)setMagazineDelegate:(id<MSMagazineListViewDelegate>)delegate {
    _magazineDelegate = delegate;
    [_magazineListView setDelegate:_magazineDelegate];
}

#pragma mark Data

- (void)reloadData {
    [_currentMagazineView reloadData];
}

- (void)loadData {
    @autoreleasepool {
        sleep(1.5);
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        if ([_delegate respondsToSelector:@selector(magazineViewDidFinishLoadingData:)]) {
            [(NSObject *)_delegate performSelectorOnMainThread:@selector(magazineViewDidFinishLoadingData:) withObject:self waitUntilDone:NO];
        }
    }
}

- (void)startLoadingProducts {
    @autoreleasepool {
        [self performSelectorInBackground:@selector(loadData) withObject:nil];
    }
}

- (void)loadProducts {
    if ([_delegate respondsToSelector:@selector(magazineViewDidStartLoadingData:)]) {
        [_delegate magazineViewDidStartLoadingData:self];
    }
    [NSThread detachNewThreadSelector:@selector(startLoadingProducts) toTarget:self withObject:nil];
}

#pragma mark Magazine list view datasource methods

- (NSArray *)magazineListViewProductsForCollectionView:(MSMagazineListView *)view {
    return _products;
}

- (NSArray *)magazineListViewProductsInfoForCollectionView:(MSMagazineListView *)view {
    return _productsInfo;
}


@end
