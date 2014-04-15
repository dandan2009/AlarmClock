//
//  MDWeatherManager.h
//  AlarmClock
//
//  Created by MARE on 14-3-9.
//  Copyright (c) 2014年 MARE. All rights reserved.
//

@import Foundation;
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>
#import "MDWeatherCondition.h"

@interface MDWeatherManager : NSObject
<CLLocationManagerDelegate>

+ (instancetype)sharedManager;

@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic, strong, readonly) MDWeatherCondition *currentCondition;

- (void)findCurrentLocation;

@end
