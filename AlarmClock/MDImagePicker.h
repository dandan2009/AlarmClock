//
//  MDImagePicker.h
//  AlarmClock
//
//  Created by IIMare on 14-5-31.
//  Copyright (c) 2014年 IIMare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDImagePicker : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *images;

// Get current page for menuViewController
@property (nonatomic, strong) UIPageControl *pagController;

- (void)scrollToCurrentPage:(NSInteger)page;

@property (nonatomic, strong) UIImageView *cellSmallImage;


@end
