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

typedef enum {
	TTTSunday = 1,
	TTTMonday,
	TTTTuesday,
	TTTWednesday,
	TTTThursday,
	TTTFriday,
	TTTSaturday,
} TTTWeekday;

extern TTTWeekday TTTWeekdayForNSDate(NSDate *date);

@interface TTTHoursOfOperationSegment : NSObject {
	NSUInteger openingHour;
	NSUInteger openingMinute;
	NSUInteger closingHour;
	NSUInteger closingMinute;
}

@property (nonatomic, assign) NSUInteger openingHour;
@property (nonatomic, assign) NSUInteger openingMinute;
@property (nonatomic, assign) NSUInteger closingHour;
@property (nonatomic, assign) NSUInteger closingMinute;

+ (id)hoursWithString:(NSString *)string;

- (NSDate *)openingDate;
- (NSDate *)closingDate;

@end

#pragma mark -
#pragma mark -

@interface TTTDailyHoursOfOperation : NSObject {
	TTTWeekday weekday;
	BOOL closed;
	NSSet *segments;
}

@property (nonatomic, assign, getter = isClosed) BOOL closed;
@property (readonly) BOOL hasDefinedHours;

- (id)initWithWeekday:(TTTWeekday)someWeekday;
+ (id)hoursWithString:(NSString *)string forWeekday:(TTTWeekday)someWeekday;
- (NSString *)description;

@end

#pragma mark -
#pragma mark -

@interface TTTWeeklyHoursOfOperation : NSObject {
	TTTDailyHoursOfOperation *sundayHours;
	TTTDailyHoursOfOperation *mondayHours;
	TTTDailyHoursOfOperation *tuesdayHours;
	TTTDailyHoursOfOperation *wednesdayHours;
	TTTDailyHoursOfOperation *thursdayHours;
	TTTDailyHoursOfOperation *fridayHours;
	TTTDailyHoursOfOperation *saturdayHours;
}

- (TTTDailyHoursOfOperation *)hoursForWeekday:(TTTWeekday)weekday;
- (void)setHoursWithString:(NSString *)string forWeekday:(TTTWeekday)weekday;
- (BOOL)isTimeWithinOpeningHours:(NSDate *)time;
- (BOOL)isCurrentTimeWithinOpeningHours;
@end
