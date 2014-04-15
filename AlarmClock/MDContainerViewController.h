//
//  MDContainerViewController.h
//  AlarmClock
//
//  Created by IIMare on 4/15/14.
//  Copyright (c) 2014 IIMare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDContainerViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *centerViewController;
@property (nonatomic, strong, readonly) UIViewController *menuViewController;
@property (nonatomic, assign) CGFloat menuViewWidth;

- (id)initWithCenterViewController:(UIViewController *)centerViewController
                menuViewController:(UIViewController *)menuViewController;

- (void)open;
- (void)close;

@end


#pragma mark The ContainerViewController Category
@interface UIViewController(MDContainerViewController)

- (MDContainerViewController *)container;

@end