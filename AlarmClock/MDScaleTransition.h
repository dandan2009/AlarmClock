//
//  MDSlideTransition.h
//  AlarmClock
//
//  Created by IIMare on 14/6/7.
//  Copyright (c) 2014年 IIMare. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    presentingAnimated,
    dismissingAnimated
}animatedTransition;

@interface MDScaleTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) animatedTransition transitionStatus;

@end
