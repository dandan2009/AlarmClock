//
//  MDTransformerFormatterDate.h
//  AlarmClock
//
//  Created by MARE on 14-3-9.
//  Copyright (c) 2014年 MARE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDTransformerDateFormatter : NSObject

- (NSString *)getCurrentTime;
- (NSString *)getCurrentDate;
- (NSString *)getCurrentWeek;
- (NSString *)getCurrentAmpm;

@end
