//
//  MDWeatherCodition.h
//  AlarmClock
//
//  Created by MARE on 14-3-9.
//  Copyright (c) 2014年 MARE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface MDWeatherCondition : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSString *icon;

- (NSString *)imageName;

@end
