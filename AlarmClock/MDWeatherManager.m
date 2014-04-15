//
//  MDWeatherManager.m
//  AlarmClock
//
//  Created by MARE on 14-3-9.
//  Copyright (c) 2014年 MARE. All rights reserved.
//

#import "MDWeatherManager.h"
#import "MDWeatherConnection.h"
#import <NZAlertView/NZAlertView.h>

@interface MDWeatherManager()

@property (nonatomic, strong, readwrite) MDWeatherCondition *currentCondition;
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstUpdate;
@property (nonatomic, strong) MDWeatherConnection *connection;

@end

@implementation MDWeatherManager

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (id)init {
    if (self = [super init]) {
        // 1
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        // 2
        _connection = [[MDWeatherConnection alloc] init];
        
        // 3
        [[[[RACObserve(self, currentLocation)
            // 4
            ignore:nil]
           // 5
           // Flatten and subscribe to all 3 signals when currentLocation updates
           flattenMap:^(CLLocation *newLocation) {
               return [RACSignal merge:@[
                                         [self updateCurrentConditions]
                                        
                                         ]];
               // 6
           }] deliverOn:RACScheduler.mainThreadScheduler]
         // 7
         subscribeError:^(NSError *error) {
             
             NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleInfo title:@"Error" message:@"There was a problem fetching the latest weather." delegate:Nil];
             [alert show];
         }];
    }
    return self;
}

- (void)findCurrentLocation {
    self.isFirstUpdate = YES;
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // 1
    if (self.isFirstUpdate) {
        self.isFirstUpdate = NO;
        return;
    }
    
    CLLocation *location = [locations lastObject];
    
    // 2
    if (location.horizontalAccuracy > 0) {
        // 3
        self.currentLocation = location;
        [self.locationManager stopUpdatingLocation];
    }
}

- (RACSignal *)updateCurrentConditions {
    return [[self.connection fetchCurrentConditionsForLocation:self.currentLocation.coordinate] doNext:^(MDWeatherCondition *condition) {
        self.currentCondition = condition;
    }];
}

@end
