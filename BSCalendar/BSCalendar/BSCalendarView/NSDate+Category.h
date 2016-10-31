//
//  NSDate+Category.h
//  Shuai
//
//  Created by 毕帅 on 16/8/17.
//  Copyright © 2016年 毕帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

/**
 *  日期格式化
 *
 *  @param style yyyy-MM-dd
 *
 *  @return String
 */
- (NSString*)formatString:(NSString*)style;

/**
 *  日期格式化
 *
 *  @param style   yyyy-MM-dd
 *  @param dateStr 1997-01-01
 *
 *  @return NSDate
 */
+ (NSDate*)formatDateWithStyle:(NSString*)style withDateString:(NSString*)dateStr;

/**
 *  比较时间
 *
 *  @param dateStr 字符串，yyyy-MM-dd
 *
 *  @return 返回当前系统时间和制定时间的差值，单位是秒
 */
+ (NSTimeInterval)compareDate:(NSString*) dateStr;

/**
 * 通过date获取日

 @return 返回天
 */
- (NSInteger)dateWithDay;

/**
 * 通过date获取月

 @return 返回月份
 */
- (NSInteger)dateWithMonth;

/**
 * 通过date获取年

 @return 返回年份
 */
- (NSInteger)dateWithYear;

/**
 * 通过date返回这个月第一个星期的第一天是星期几

 @return 返回星期几
 */
- (NSInteger)dateWithFirstWeekdayInThisMonth;

/**
 * 通过date返回这个月一共有多少天

 @return 返回天数
 */
- (NSInteger)dateWithTotaldaysInThisMonth;

/**
 * 通过date得到上个月的date

 @return 返回上个月date
 */
- (NSDate *)dateWithLastMonth;

/**
 * 通过date得到下个月date

 @return 返回下个月date
 */
- (NSDate *)dateWithNextMonth;

@end
