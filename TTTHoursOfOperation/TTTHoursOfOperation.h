// TTTHoursOfOperation.h
//
// Copyright (c) 2011 Mattt Thompson (http://mattt.me)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

/**
 Specifies the day of the week.
 */
typedef enum {
	TTTSunday = 1,
	TTTMonday,
	TTTTuesday,
	TTTWednesday,
	TTTThursday,
	TTTFriday,
	TTTSaturday,
} TTTWeekday;

/**
 Returns the day of the week for a specified date.
 */
extern TTTWeekday TTTWeekdayForNSDate(NSDate *date);

@class TTTDailyHoursOfOperation;

/**
 Instances of `TTTWeeklyHoursOfOperation` represent the weekly hours of operation for an establishment.
 */
@interface TTTWeeklyHoursOfOperation : NSObject

/**
 Returns the hours of operation on a particular day of the week.
 
 @param weekday The day of the week.
 */
- (TTTDailyHoursOfOperation *)hoursForWeekday:(TTTWeekday)weekday;

/**
 Sets the daily hours of operation for a particular day of the week from a formatted time interval string.
 
 @param string The time interval string parsed to determine hours of operation. The format for this string is two 24-hour times separated by a dash, such as "08:00-19:00"
 */
- (void)setHoursWithString:(NSString *)string 
                forWeekday:(TTTWeekday)weekday;

/**
 Returns whether the specified time is open during the weekly hours of operation.
 
 @param time The time to check for opening hours
 */
- (BOOL)isTimeWithinOpeningHours:(NSDate *)time;

/**
 Returns whether the current time is open within the weekly hours of operation. 
 */
- (BOOL)isCurrentTimeWithinOpeningHours;

@end

#pragma mark -

/**
 Instances of `TTTDailyHoursOfOperation` represent the daily hours of operation for an establishment on a particular weekday. 
 */
@interface TTTDailyHoursOfOperation : NSObject

/**
 Specifies whether an establishment is closed on this particular weekday.
 */
@property (nonatomic, assign, getter = isClosed) BOOL closed;

/**
 Specifies whether an establishment has defined hours of operation on this particular weekday.
 */
@property (readonly) BOOL hasDefinedHours;

@end
