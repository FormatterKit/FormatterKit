// TTTTimeIntervalFormatter.h
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
 Instances of `TTTTimeIntervalFormatter` create localized string representations of `NSTimeInterval` values.

 For example, a time interval of -75 would be formatted as @"1 minute ago" in English.
 */
@interface TTTTimeIntervalFormatter : NSFormatter

/**
 Specifies the locale used to format strings. Defaults to the current system locale.
 */
@property (nonatomic, strong) NSLocale *locale;

/**
 Specifies the calendar used in date calculation. Defaults to the current system calendar.
 */
@property (nonatomic, strong) NSCalendar *calendar;

/**
 Specifies the localized string used to express the past deictic expression. "ago" by default.
 */
@property (nonatomic, strong) NSString *pastDeicticExpression;

/**
 Specifies the localized string used to express the present deictic expression. "just now" by default.
 */
@property (nonatomic, strong) NSString *presentDeicticExpression;

/**
 Specifies the localized string used to express the future deictic expression. "from now" by default.
 */
@property (nonatomic, strong) NSString *futureDeicticExpression;

/**
 Specifies the localized string used to format the time interval string and deictic expression. Defaults to a format with the deictic expression following the time interval
 */
@property (nonatomic, strong) NSString *deicticExpressionFormat;

/**
 Specifies the time interval before and after the present moment that is described as still being in the present, rather than the past or future. Defaults to 1 second.
 */
@property (nonatomic, assign) NSTimeInterval presentTimeIntervalMargin;

/**
 Specifies the localized string used to qualify a time interval as being an approximate time. "about" by default.
 */
@property (nonatomic, strong) NSString *approximateQualifierFormat;

/**
 Specifies whether to use an approximate qualifier when the described interval is not exact. `NO` by default.
 */
@property (nonatomic, assign) BOOL usesApproximateQualifier;

/**
 Specifies whether to use abbreviated calendar units to describe time intervals, for instance "wks" instead of "weeks" in English. Defaults to `NO`.
 */
@property (nonatomic, assign) BOOL usesAbbreviatedCalendarUnits;

/**
 Specifies whether to use idiomatic deictic expressions when available, such as "last week" instead of "1 week ago". Defaults to `NO`.

 @discussion This implementation is entirely separate from the equivalent behavior used by `NSDateFormatter`.
 */
@property (nonatomic, assign) BOOL usesIdiomaticDeicticExpressions;

/**
 Returns a string representation of a time interval formatted using the receiver’s current settings.

 @param seconds The number of seconds to add to the receiver. Use a negative value for seconds to have the returned object specify a date before the receiver.
 */
- (NSString *)stringForTimeInterval:(NSTimeInterval)seconds;

/**
 Returns a string representation of the time interval between two specified dates formatted using the receiver’s current settings.

 @param startingDate The starting date
 @param endingDate The ending date
 */
- (NSString *)stringForTimeIntervalFromDate:(NSDate *)startingDate
                                     toDate:(NSDate *)endingDate;

@end
