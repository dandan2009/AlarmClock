//
//  MDContainerViewController.h
//  AlarmClock
//
//  Created by IIMare on 4/15/14.
//  Copyright (c) 2014 IIMare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDContainerViewController : UIViewController

/** To Accoss The Concent View Controller Add Two Property **/

@property (nonatomic, strong, readonly) UIViewController *centerViewController;
@property (nonatomic, strong, readonly) UIViewController *menuViewController;


/** Some Configuration To ContainerViewController **/

@property (nonatomic, assign) CGFloat menuViewWidth;


/** The Initialize Method Add Two ViewController for Container **/

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