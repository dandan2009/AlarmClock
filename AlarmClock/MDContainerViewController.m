//
//  MDContainerViewController.m
//  AlarmClock
//
//  Created by IIMare on 4/15/14.
//  Copyright (c) 2014 IIMare. All rights reserved.
//

#import "MDContainerViewController.h"
#import "MDShadowVCenterContainerView.h"

@interface MDContainerViewController ()

@property (nonatomic, strong, readwrite) UIViewController *centerViewController;
@property (nonatomic, strong, readwrite) UIViewController *menuViewController;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) MDShadowVCenterContainerView *centerContainerView;
@property (nonatomic, strong) UIView *menuContainerView;

@end


@implementation MDContainerViewController



@end


#pragma mark - The MDContainerViewController Category Implementation
@implementation UIViewController(MDContainerViewController)

- (MDContainerViewController *)container
{
    UIViewController *parent = self;
    Class containerClass = [MDContainerViewController class];
    
    while (nil != (parent = [parent parentViewController]) && ![parent isKindOfClass:containerClass]) {
        
    }
    return (id)parent;
    
}

@end