//
//  MDContainerViewController.h
//  AlarmClock
//
//  Created by IIMare on 4/15/14.
//  Copyright (c) 2014 IIMare. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MDContainerViewControllerState) {
    MDContainerViewControllerClosed = 0,
    MDContainerViewControllerOpen,
    MDContainerViewControllerClosing,
    MDContainerViewControllerOpening
};

@interface MDContainerViewController : UIViewController


@property (nonatomic, strong, readonly) UIViewController *centerViewController;
@property (nonatomic, strong, readonly) UIViewController *menuViewController;
@property (nonatomic, assign) MDContainerViewControllerState containerState;

@property (nonatomic, assign) CGFloat menuViewWidth;



- (id)initWithCenterViewController:(UIViewController *)centerViewController
                menuViewController:(UIViewController *)menuViewController;



/** Invoking This Method Can Open The MenuView **/
- (void)openTheMenu;

/** This Method Can Close The MenuView And Display The CenterView **/
- (void)closeTheMenu;

@end


#pragma mark The ContainerViewController Category
@interface UIViewController(MDContainerViewController)

- (MDContainerViewController *)container;

@end


