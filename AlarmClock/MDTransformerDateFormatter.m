//
//  MDTransformerFormatterDate.m
//  AlarmClock
//
//  Created by MARE on 14-3-9.
//  Copyright (c) 2014年 MARE. All rights reserved.
//

#import "MDTransformerDateFormatter.h"

@interface MDTransformerDateFormatter()

@property (nonatomic, strong) NSDateFormatter *timeFormatter;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDateFormatter *weekFormatter;
@property (nonatomic, strong) NSDateFormatter *ampmFormatter;

@end

@implementation MDTransformerDateFormatter

- (id)init
{
    if (self = [super init]) {
        
        _timeFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter = [[NSDateFormatter alloc] init];
        _weekFormatter = [[NSDateFormatter alloc] init];
        _ampmFormatter = [[NSDateFormatter alloc] init];
        
        
    }
    return self;
}

- (NSString *)getCurrentTime
{
    [self.timeFormatter setDateFormat:@"hh:mm"];
    return [self.timeFormatter stringFromDate:[NSDate date]];
}

- (NSString *)getCurrentDate
{
    [self.dateFormatter setDateFormat:@"yyyy/MM/dd"];
    return [self.dateFormatter stringFromDate:[NSDate date]];
}

- (NSString *)getCurrentWeek
{
    [self.weekFormatter setDateFormat:@"EEE"];
    return [self.weekFormatter stringFromDate:[NSDate date]];
}

- (NSString *)getCurrentAmpm
{
    [self.ampmFormatter setDateFormat:@"a"];
    return [self.ampmFormatter stringFromDate:[NSDate date]];
}


@end
