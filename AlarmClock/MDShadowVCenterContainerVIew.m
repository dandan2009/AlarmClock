//
//  MDShadowVCenterContainerVIew.m
//  AlarmClock
//
//  Created by IIMare on 4/15/14.
//  Copyright (c) 2014 IIMare. All rights reserved.
//

#import "MDShadowVCenterContainerView.h"

@implementation MDShadowVCenterContainerView

- (void)drawRect:(CGRect)rect
{
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = 0.7f;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = shadowPath.CGPath;
}

@end
