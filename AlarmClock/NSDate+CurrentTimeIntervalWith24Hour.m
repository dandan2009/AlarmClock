//
//  NSDate+CurrentTimeIntervalWith24Hour.m
//  AlarmClock
//
//  Created by MARE on 14-3-10.
//  Copyright (c) 2014年 MARE. All rights reserved.
//

#import "NSDate+CurrentTimeIntervalWith24Hour.h"

@implementation NSDate (CurrentTimeIntervalWith24Hour)

+ (float)getCurrentTimeIntervalWith24Hour
{
    // Total time with 24 hour
    float totalTime = 24 * 60 * 60;
    
    // Current time string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *currentTimeString = [dateFormatter stringFromDate:[NSDate date]];
    
    // Using the NSRegularExpression find the hour minute and second
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:@"(.*):(.*):(.*)" options:0 error:Nil];
    NSArray *matches = [reg matchesInString:currentTimeString options:0 range:NSMakeRange(0, [currentTimeString length])];
    NSTextCheckingResult *result = [matches objectAtIndex:0];
    
    // Find the hour minute and second range
    NSRange hourRange = [result rangeAtIndex:1];
    NSRange minuteRange = [result rangeAtIndex:2];
    NSRange secondRange = [result rangeAtIndex:3];
    
    // Get the hour minute second and transformers stirng to int
    int hour = [[currentTimeString substringWithRange:hourRange] intValue];
    int minute = [[currentTimeString substringWithRange:minuteRange] intValue];
    int second = [[currentTimeString substringWithRange:secondRange] intValue];
    NSLog(@"the hour is %d minute is %d and second is %d",hour,minute,second);
    
    NSTimeInterval intervalTime = totalTime - ((hour * 60 * 60) + (minute * 60) + second);
    NSLog(@"Interval time of current time is: %f",intervalTime);
    
    return intervalTime;
}

@end
