//
//  NSDate+Category.m
//  Shuai
//
//  Created by 毕帅 on 16/8/17.
//  Copyright © 2016年 毕帅. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

- (NSString *)formatString:(NSString *)style{
    NSDateFormatter * df = [NSDateFormatter new];
    df.dateFormat = style;
    return [df stringFromDate:self];
}

+ (NSDate *)formatDateWithStyle:(NSString *)style withDateString:(NSString *)dateStr{
    NSDateFormatter * df = [NSDateFormatter new];
    df.dateFormat = style;
    df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [df dateFromString:dateStr];
}

+ (NSTimeInterval)compareDate:(NSString *)dateStr{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate* birth = [formatter dateFromString:dateStr];
    
    
    NSTimeInterval result = [[NSDate date] timeIntervalSinceDate:birth];
    return result;
}

- (NSInteger)dateWithDay{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components day];
}


- (NSInteger)dateWithMonth{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components month];
}

- (NSInteger)dateWithYear{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components year];
}

- (NSInteger)dateWithFirstWeekdayInThisMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)dateWithTotaldaysInThisMonth{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return totaldaysInMonth.length;
}

- (NSDate *)dateWithLastMonth{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate*)dateWithNextMonth{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

@end
