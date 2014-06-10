//
//  MDAddViewController.h
//  AlarmClock
//
//  Created by IIMare on 14/6/5.
//  Copyright (c) 2014年 IIMare. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDAddViewController;
@protocol MDAddViewControllerDelegate <NSObject>
- (void)dissmissTheAddViewController:(MDAddViewController *)addViewController;
@end

@interface MDAddViewController : UIViewController

@property (nonatomic, weak) id<MDAddViewControllerDelegate>delegate;

@end
