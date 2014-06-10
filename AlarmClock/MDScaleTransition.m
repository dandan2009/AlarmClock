//
//  MDSlideTransition.m
//  AlarmClock
//
//  Created by IIMare on 14/6/7.
//  Copyright (c) 2014年 IIMare. All rights reserved.
//

#import "MDScaleTransition.h"

@implementation MDScaleTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.transitionStatus == presentingAnimated) {
        return 0.3f;
    } else if (self.transitionStatus == dismissingAnimated) {
        return 0.3f;
    } else {
        return 0;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Get the from view controller and to view controller and container view
    
    /** From View Controller **/
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    /** To View Controller **/
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    /** Container View **/
    UIView *containerView = [transitionContext containerView];
    
    

    if (self.transitionStatus == presentingAnimated) {
        
        toVC.view.alpha = 0.0f;
        CGAffineTransform transForm = toVC.view.transform;
        toVC.view.transform = CGAffineTransformScale(transForm, 2.0, 2.0);
        [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             toVC.view.alpha = 1.0f;
                             toVC.view.transform = CGAffineTransformScale(transForm, 1.0, 1.0);
                             fromVC.view.transform = CGAffineTransformScale(transForm, 0.9, 0.9);
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
        
    } else if (self.transitionStatus == dismissingAnimated) {
        
        fromVC.view.alpha = 1.0f;
        CGAffineTransform transForm = fromVC.view.transform;
        fromVC.view.transform = CGAffineTransformScale(transForm, 1.0, 1.0);
        [containerView insertSubview:toVC.view belowSubview:fromVC.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             fromVC.view.alpha = 0.0f;
                             fromVC.view.transform = CGAffineTransformScale(transForm, 2.0, 2.0);
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
        
    }
    
    
}

@end
