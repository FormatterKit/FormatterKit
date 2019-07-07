// TTTTimeIntervalFormatter.m
//
// Copyright (c) 2011–2019 Mattt (https://mat.tt)
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

#import "TTTTimeIntervalFormatter.h"
#import "NSBundle+FormatterKit.h"

#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)
    #define TTTCalendarUnitYear NSCalendarUnitYear
    #define TTTCalendarUnitMonth NSCalendarUnitMonth
    #define TTTCalendarUnitWeek NSCalendarUnitWeekOfYear
    #define TTTCalendarUnitDay NSCalendarUnitDay
    #define TTTCalendarUnitHour NSCalendarUnitHour
    #define TTTCalendarUnitMinute NSCalendarUnitMinute
    #define TTTCalendarUnitSecond NSCalendarUnitSecond
    #define TTTDateComponentUndefined NSDateComponentUndefined
#else
    #define TTTCalendarUnitYear NSYearCalendarUnit
    #define TTTCalendarUnitMonth NSMonthCalendarUnit
    #define TTTCalendarUnitWeek NSWeekOfYearCalendarUnit
    #define TTTCalendarUnitDay NSDayCalendarUnit
    #define TTTCalendarUnitHour NSHourCalendarUnit
    #define TTTCalendarUnitMinute NSMinuteCalendarUnit
    #define TTTCalendarUnitSecond NSSecondCalendarUnit
    #define TTTDateComponentUndefined NSUndefinedDateComponent
#endif

static inline NSCalendarUnit NSCalendarUnitFromString(NSString *string) {
    if ([string isEqualToString:@"year"]) {
        return TTTCalendarUnitYear;
    } else if ([string isEqualToString:@"month"]) {
        return TTTCalendarUnitMonth;
    } else if ([string isEqualToString:@"weekOfYear"]) {
        return TTTCalendarUnitWeek;
    } else if ([string isEqualToString:@"day"]) {
        return TTTCalendarUnitDay;
    } else if ([string isEqualToString:@"hour"]) {
        return TTTCalendarUnitHour;
    } else if ([string isEqualToString:@"minute"]) {
        return TTTCalendarUnitMinute;
    } else if ([string isEqualToString:@"second"]) {
        return TTTCalendarUnitSecond;
    }

    return TTTDateComponentUndefined;
}

static inline NSComparisonResult NSCalendarUnitCompareSignificance(NSCalendarUnit a, NSCalendarUnit b) {
    if ((a == TTTCalendarUnitWeek) ^ (b == TTTCalendarUnitWeek)) {
        if (b == TTTCalendarUnitWeek) {
            switch (a) {
                case TTTCalendarUnitYear:
                case TTTCalendarUnitMonth:
                    return NSOrderedDescending;
                default:
                    return NSOrderedAscending;
            }
        } else {
            switch (b) {
                case TTTCalendarUnitYear:
                case TTTCalendarUnitMonth:
                    return NSOrderedAscending;
                default:
                    return NSOrderedDescending;
            }
        }
    } else {
        if (a > b) {
            return NSOrderedAscending;
        } else if (a < b) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }
}

@implementation TTTTimeIntervalFormatter
@synthesize locale = _locale;
@synthesize calendar = _calendar;
@synthesize pastDeicticExpression = _pastDeicticExpression;
@synthesize presentDeicticExpression = _presentDeicticExpression;
@synthesize futureDeicticExpression = _futureDeicticExpression;
@synthesize pastDeicticExpressionFormat = _pastDeicticExpressionFormat;
@synthesize futureDeicticExpressionFormat = _futureDeicticExpressionFormat;
@synthesize suffixExpressionFormat = _suffixExpressionFormat;
@synthesize approximateQualifierFormat = _approximateQualifierFormat;
@synthesize presentTimeIntervalMargin = _presentTimeIntervalMargin;
@synthesize usesAbbreviatedCalendarUnits = _usesAbbreviatedCalendarUnits;
@synthesize usesApproximateQualifier = _usesApproximateQualifier;
@synthesize usesIdiomaticDeicticExpressions = _usesIdiomaticDeicticExpressions;
@synthesize numberOfSignificantUnits = _numberOfSignificantUnits;
@synthesize leastSignificantUnit = _leastSignificantUnit;
@synthesize significantUnits = _significantUnits;

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.locale = [NSLocale currentLocale];
    self.calendar = [NSCalendar currentCalendar];

    self.pastDeicticExpression = NSLocalizedStringFromTableInBundle(@"ago", @"FormatterKit", [NSBundle formatterKitBundle], @"Past Deictic Expression");
    self.presentDeicticExpression = NSLocalizedStringFromTableInBundle(@"just now", @"FormatterKit", [NSBundle formatterKitBundle], @"Present Deictic Expression");
    self.futureDeicticExpression = NSLocalizedStringFromTableInBundle(@"from now", @"FormatterKit", [NSBundle formatterKitBundle], @"Future Deictic Expression");

    self.pastDeicticExpressionFormat = NSLocalizedStringWithDefaultValue(@"Past Deictic Expression Format String", @"FormatterKit", [NSBundle formatterKitBundle], @"%@ %@", @"Past Deictic Expression Format (#{Time} #{Ago/From Now}");
    self.futureDeicticExpressionFormat = NSLocalizedStringWithDefaultValue(@"Future Deictic Expression Format String", @"FormatterKit", [NSBundle formatterKitBundle], @"%@ %@", @"Future Deictic Expression Format (#{In} #{Time}");
    self.approximateQualifierFormat = NSLocalizedStringFromTableInBundle(@"about %@", @"FormatterKit", [NSBundle formatterKitBundle], @"Approximate Qualifier Format");
    self.suffixExpressionFormat = NSLocalizedStringWithDefaultValue(@"Suffix Expression Format String", @"FormatterKit", [NSBundle formatterKitBundle], @"%@ %@", @"Suffix Expression Format (#{Time} #{Unit})");

    self.presentTimeIntervalMargin = 1;

    self.significantUnits = TTTCalendarUnitYear | TTTCalendarUnitMonth | TTTCalendarUnitWeek | TTTCalendarUnitDay | TTTCalendarUnitHour | TTTCalendarUnitMinute | TTTCalendarUnitSecond;
    self.numberOfSignificantUnits = 1;
    self.leastSignificantUnit = TTTCalendarUnitSecond;

    return self;
}

- (BOOL)shouldUseUnit:(NSCalendarUnit)unit
{
    return (self.significantUnits & unit) && NSCalendarUnitCompareSignificance(self.leastSignificantUnit, unit) != NSOrderedDescending;
}

- (NSDateComponents *)componentsWithoutTime:(NSDate *)date {
    NSCalendarUnit units = TTTCalendarUnitYear | TTTCalendarUnitMonth | TTTCalendarUnitWeek | TTTCalendarUnitDay;
    return [self.calendar components:units fromDate:date];
}

- (NSInteger)numberOfDaysFrom:(NSDate *)fromDate to:(NSDate *)toDate {
    NSDateComponents *fromComponents = [self componentsWithoutTime:fromDate];
    NSDateComponents *toComponents = [self componentsWithoutTime:toDate];
    fromDate = [self.calendar dateFromComponents:fromComponents];
    toDate = [self.calendar dateFromComponents:toComponents];

    return [self.calendar components:TTTCalendarUnitDay fromDate:fromDate toDate:toDate options:0].day;
}

- (NSString *)stringForTimeInterval:(NSTimeInterval)seconds {
    NSDate *date = [NSDate date];
    return [self stringForTimeIntervalFromDate:date toDate:[NSDate dateWithTimeInterval:seconds sinceDate:date]];
}

- (NSString *)stringForTimeIntervalFromDate:(NSDate *)startingDate
                                     toDate:(NSDate *)endingDate
{
    NSTimeInterval seconds = [startingDate timeIntervalSinceDate:endingDate];
    if (fabs(seconds) < self.presentTimeIntervalMargin) {
        return self.presentDeicticExpression;
    }

    if (self.usesIdiomaticDeicticExpressions) {
        NSString *idiomaticDeicticExpression = [self idiomaticDeicticExpressionForStartingDate:startingDate endingDate:endingDate];
        if (idiomaticDeicticExpression) {
            return idiomaticDeicticExpression;
        }
    }

    NSDateComponents *components = [self.calendar components:self.significantUnits fromDate:startingDate toDate:endingDate options:0];
    NSString *string = nil;
    BOOL isApproximate = NO;
    NSUInteger numberOfUnits = 0;
    for (NSString *unitName in @[@"year", @"month", @"weekOfYear", @"day", @"hour", @"minute", @"second"]) {
        NSCalendarUnit unit = NSCalendarUnitFromString(unitName);
        if ([self shouldUseUnit:unit]) {
            BOOL reportOnlyDays = unit == TTTCalendarUnitDay && self.numberOfSignificantUnits == 1;
            NSInteger value = reportOnlyDays ? [self numberOfDaysFrom:startingDate to:endingDate] : [[components valueForKey:unitName] integerValue];
            if (value) {
                NSNumber *number = @(abs((int)value));
                NSString *suffix = [NSString stringWithFormat:self.suffixExpressionFormat, number, [self localizedStringForNumber:[number unsignedIntegerValue] ofCalendarUnit:unit]];
                if (!string) {
                    string = suffix;
                } else if (self.numberOfSignificantUnits == 0 || numberOfUnits < self.numberOfSignificantUnits) {
                    string = [string stringByAppendingFormat:@" %@", suffix];
                } else {
                    isApproximate = YES;
                }

                numberOfUnits++;
            }
        }
    }

    if (string) {
        if (seconds > 0) {
            if ([self.pastDeicticExpression length]) {
                string = [NSString stringWithFormat:self.pastDeicticExpressionFormat, string, self.pastDeicticExpression];
            }
        } else {
            if ([self.futureDeicticExpression length]) {
                string = [NSString stringWithFormat:self.futureDeicticExpressionFormat, string, self.futureDeicticExpression];
            }
        }

        if (isApproximate && self.usesApproximateQualifier) {
            string = [NSString stringWithFormat:self.approximateQualifierFormat, string];
        }
    } else {
        string = self.presentDeicticExpression;
    }

    return string;
}

- (NSString *)localizedStringForNumber:(NSUInteger)number ofCalendarUnit:(NSCalendarUnit)unit {
    BOOL singular = (number == 1);

    if (self.usesAbbreviatedCalendarUnits) {
        switch (unit) {
            case TTTCalendarUnitYear:
                return singular ? NSLocalizedStringFromTableInBundle(@"yr", @"FormatterKit", [NSBundle formatterKitBundle], @"Year Unit (Singular, Abbreviated)") : NSLocalizedStringFromTableInBundle(@"yrs", @"FormatterKit", [NSBundle formatterKitBundle], @"Year Unit (Plural, Abbreviated)");
            case TTTCalendarUnitMonth:
                return singular ? NSLocalizedStringFromTableInBundle(@"mo", @"FormatterKit", [NSBundle formatterKitBundle], @"Month Unit (Singular, Abbreviated)") : NSLocalizedStringFromTableInBundle(@"mos", @"FormatterKit", [NSBundle formatterKitBundle], @"Month Unit (Plural, Abbreviated)");
            case TTTCalendarUnitWeek:
                return singular ? NSLocalizedStringFromTableInBundle(@"wk", @"FormatterKit", [NSBundle formatterKitBundle], @"Week Unit (Singular, Abbreviated)") : NSLocalizedStringFromTableInBundle(@"wks", @"FormatterKit", [NSBundle formatterKitBundle], @"Week Unit (Plural, Abbreviated)");
            case TTTCalendarUnitDay:
                return singular ? NSLocalizedStringFromTableInBundle(@"d", @"FormatterKit", [NSBundle formatterKitBundle], @"Day Unit (Singular, Abbreviated)") : NSLocalizedStringFromTableInBundle(@"ds", @"FormatterKit", [NSBundle formatterKitBundle], @"Day Unit (Plural, Abbreviated)");
            case TTTCalendarUnitHour:
                return singular ? NSLocalizedStringFromTableInBundle(@"hr", @"FormatterKit", [NSBundle formatterKitBundle], @"Hour Unit (Singular, Abbreviated)") : NSLocalizedStringFromTableInBundle(@"hrs", @"FormatterKit", [NSBundle formatterKitBundle], @"Hour Unit (Plural, Abbreviated)");
            case TTTCalendarUnitMinute:
                return singular ? NSLocalizedStringFromTableInBundle(@"min", @"FormatterKit", [NSBundle formatterKitBundle], @"Minute Unit (Singular, Abbreviated)") : NSLocalizedStringFromTableInBundle(@"mins", @"FormatterKit", [NSBundle formatterKitBundle], @"Minute Unit (Plural, Abbreviated)");
            case TTTCalendarUnitSecond:
                return singular ? NSLocalizedStringFromTableInBundle(@"s", @"FormatterKit", [NSBundle formatterKitBundle], @"Second Unit (Singular, Abbreviated)") : NSLocalizedStringFromTableInBundle(@"s", @"FormatterKit", [NSBundle formatterKitBundle], @"Second Unit (Plural, Abbreviated)");
            default:
                return nil;
        }
    } else {
        switch (unit) {
            case TTTCalendarUnitYear:
                return singular ? NSLocalizedStringFromTableInBundle(@"year", @"FormatterKit", [NSBundle formatterKitBundle], @"Year Unit (Singular)") : NSLocalizedStringFromTableInBundle(@"years", @"FormatterKit", [NSBundle formatterKitBundle], @"Year Unit (Plural)");
            case TTTCalendarUnitMonth:
                return singular ? NSLocalizedStringFromTableInBundle(@"month", @"FormatterKit", [NSBundle formatterKitBundle], @"Month Unit (Singular)") : NSLocalizedStringFromTableInBundle(@"months", @"FormatterKit", [NSBundle formatterKitBundle], @"Month Unit (Plural)");
            case TTTCalendarUnitWeek:
                return singular ? NSLocalizedStringFromTableInBundle(@"week", @"FormatterKit", [NSBundle formatterKitBundle], @"Week Unit (Singular)") : NSLocalizedStringFromTableInBundle(@"weeks", @"FormatterKit", [NSBundle formatterKitBundle], @"Week Unit (Plural)");
            case TTTCalendarUnitDay:
                return singular ? NSLocalizedStringFromTableInBundle(@"day", @"FormatterKit", [NSBundle formatterKitBundle], @"Day Unit (Singular)") : NSLocalizedStringFromTableInBundle(@"days", @"FormatterKit", [NSBundle formatterKitBundle], @"Day Unit (Plural)");
            case TTTCalendarUnitHour:
                return singular ? NSLocalizedStringFromTableInBundle(@"hour", @"FormatterKit", [NSBundle formatterKitBundle], @"Hour Unit (Singular)") : NSLocalizedStringFromTableInBundle(@"hours", @"FormatterKit", [NSBundle formatterKitBundle], @"Hour Unit (Plural)");
            case TTTCalendarUnitMinute:
                return singular ? NSLocalizedStringFromTableInBundle(@"minute", @"FormatterKit", [NSBundle formatterKitBundle], @"Minute Unit (Singular)") : NSLocalizedStringFromTableInBundle(@"minutes", @"FormatterKit", [NSBundle formatterKitBundle], @"Minute Unit (Plural)");
            case TTTCalendarUnitSecond:
                return singular ? NSLocalizedStringFromTableInBundle(@"second", @"FormatterKit", [NSBundle formatterKitBundle], @"Second Unit (Singular)") : NSLocalizedStringFromTableInBundle(@"seconds", @"FormatterKit", [NSBundle formatterKitBundle], @"Second Unit (Plural)");
            default:
                return nil;
        }
    }
}

#pragma mark -

- (NSString *)idiomaticDeicticExpressionForStartingDate:(NSDate *)startingDate endingDate:(NSDate *)endingDate {
    NSDateComponents *startingComponents = [self componentsWithoutTime:startingDate];
    NSDateComponents *endingComponents = [self componentsWithoutTime:endingDate];

    NSInteger dayDifference = [self numberOfDaysFrom:startingDate to:endingDate];
    if ([self shouldUseUnit:TTTCalendarUnitDay] && dayDifference == -1) {
        return NSLocalizedStringFromTable(@"yesterday", @"FormatterKit", @"yesterday");
    }
    if ([self shouldUseUnit:TTTCalendarUnitDay] && dayDifference == 1) {
        return NSLocalizedStringFromTable(@"tomorrow", @"FormatterKit", @"tomorrow");
    }

    BOOL sameYear = startingComponents.year == endingComponents.year;
    BOOL previousYear = startingComponents.year - 1 == endingComponents.year;
    BOOL nextYear = startingComponents.year + 1 == endingComponents.year;

    BOOL sameMonth = sameYear && startingComponents.month == endingComponents.month;
    BOOL previousMonth = (sameYear && startingComponents.month - 1 == endingComponents.month) || (previousYear && startingComponents.month == 1 && endingComponents.month == 12);
    BOOL nextMonth = (sameYear && startingComponents.month + 1 == endingComponents.month) || (nextYear && startingComponents.month == 12 && endingComponents.month == 1);

    long numberOfWeeks = MAX(MAX(startingComponents.weekOfYear, endingComponents.weekOfYear), 52);
    BOOL precedingWeekNumber = (endingComponents.weekOfYear % numberOfWeeks) + 1 == startingComponents.weekOfYear;
    BOOL succeedingWeekNumber = (startingComponents.weekOfYear % numberOfWeeks) + 1 == endingComponents.weekOfYear;
    BOOL previousWeek = precedingWeekNumber && (sameMonth || previousMonth);
    BOOL nextWeek = succeedingWeekNumber && (sameMonth || nextMonth);

    if ([self shouldUseUnit:TTTCalendarUnitWeek] && previousWeek) {
        return NSLocalizedStringFromTable(@"last week", @"FormatterKit", @"last week");
    }
    if ([self shouldUseUnit:TTTCalendarUnitWeek] && nextWeek) {
        return NSLocalizedStringFromTable(@"next week", @"FormatterKit", @"next week");
    }

    if ([self shouldUseUnit:TTTCalendarUnitMonth] && previousMonth) {
        return NSLocalizedStringFromTable(@"last month", @"FormatterKit", @"last month");
    }
    if ([self shouldUseUnit:TTTCalendarUnitMonth] && nextMonth) {
        return NSLocalizedStringFromTable(@"next month", @"FormatterKit", @"next month");
    }

    if ([self shouldUseUnit:TTTCalendarUnitYear] && previousYear) {
        return NSLocalizedStringFromTable(@"last year", @"FormatterKit", @"last year");
    }
    if ([self shouldUseUnit:TTTCalendarUnitYear] && nextYear) {
        return NSLocalizedStringFromTable(@"next year", @"FormatterKit", @"next year");
    }

    return nil;
}

- (NSString *)caRelativeDateStringForComponents:(NSDateComponents *)components {
    if ([components day] == -2 && [components year] == 0 && [components month] == 0 && [components weekOfYear] == 0) {
        return @"abans d'ahir";
    }

    if ([components day] == 2 && [components year] == 0 && [components month] == 0 && [components weekOfYear] == 0) {
        return @"passat demà";
    }

    return nil;
}

- (NSString *)heRelativeDateStringForComponents:(NSDateComponents *)components {
    if ([components year] == -2) {
        return @"לפני שנתיים";
    } else if ([components month] == -2 && [components year] == 0) {
        return @"לפני חודשיים";
    } else if ([components weekOfYear] == -2 && [components year] == 0 && [components month] == 0) {
        return @"לפני שבועיים";
    } else if ([components day] == -2 && [components year] == 0 && [components month] == 0 && [components weekOfYear] == 0) {
        return @"שלשום";
    }

    if ([components year] == 2) {
        return @"בעוד שנתיים";
    } else if ([components month] == 2 && [components year] == 0) {
        return @"בעוד חודשיים";
    } else if ([components weekOfYear] == 2 && [components year] == 0 && [components month] == 0) {
        return @"בעוד שבועיים";
    } else if ([components day] == 2 && [components year] == 0 && [components month] == 0 && [components weekOfYear] == 0) {
        return @"מחרתיים";
    }

    return nil;
}

- (NSString *)nlRelativeDateStringForComponents:(NSDateComponents *)components {
    if ([components day] == -2 && [components year] == 0 && [components month] == 0 && [components weekOfYear] == 0) {
        return @"eergisteren";
    }

    if ([components day] == 2 && [components year] == 0 && [components month] == 0 && [components weekOfYear] == 0) {
        return @"overmorgen";
    }

    return nil;
}

- (NSString *)plRelativeDateStringForComponents:(NSDateComponents *)components {
    if ([components day] == -2 && [components year] == 0 && [components month] == 0 && [components weekOfYear] == 0) {
        return @"przedwczoraj";
    }

    if ([components day] == 2 && [components year] == 0 && [components month] == 0 && [components weekOfYear] == 0) {
        return @"pojutrze";
    }

    return nil;
}

- (NSString *)csRelativeDateStringForComponents:(NSDateComponents *)components {
    if ([components day] == -2 && [components weekOfYear] == 0 && [components month] == 0 && [components year] == 0) {
        return @"předevčírem";
    }

    if ([components day] == 2 && [components weekOfYear] == 0 && [components month] == 0 && [components year] == 0) {
        return @"pozítří";
    }

    return nil;
}

#pragma mark - NSFormatter

- (NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[NSNumber class]]) {
        return nil;
    }

    return [self stringForTimeInterval:[(NSNumber *)anObject doubleValue]];
}

- (BOOL)getObjectValue:(out __unused __autoreleasing id *)obj
             forString:(__unused NSString *)string
      errorDescription:(out NSString *__autoreleasing *)error
{
    *error = NSLocalizedStringFromTableInBundle(@"Method Not Implemented", @"FormatterKit", [NSBundle formatterKitBundle], nil);

    return NO;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    TTTTimeIntervalFormatter *formatter = [[[self class] allocWithZone:zone] init];

    formatter.locale = [self.locale copyWithZone:zone];
    formatter.pastDeicticExpression = [self.pastDeicticExpression copyWithZone:zone];
    formatter.presentDeicticExpression = [self.presentDeicticExpression copyWithZone:zone];
    formatter.futureDeicticExpression = [self.futureDeicticExpression copyWithZone:zone];
    formatter.pastDeicticExpressionFormat = [self.pastDeicticExpressionFormat copyWithZone:zone];
    formatter.futureDeicticExpressionFormat = [self.futureDeicticExpressionFormat copyWithZone:zone];
    formatter.approximateQualifierFormat = [self.approximateQualifierFormat copyWithZone:zone];
    formatter.presentTimeIntervalMargin = self.presentTimeIntervalMargin;
    formatter.usesAbbreviatedCalendarUnits = self.usesAbbreviatedCalendarUnits;
    formatter.usesApproximateQualifier = self.usesApproximateQualifier;
    formatter.usesIdiomaticDeicticExpressions = self.usesIdiomaticDeicticExpressions;

    return formatter;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    self.locale = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(locale))];
    self.pastDeicticExpression = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(pastDeicticExpression))];
    self.presentDeicticExpression = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(presentDeicticExpression))];
    self.futureDeicticExpression = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(futureDeicticExpression))];
    self.pastDeicticExpressionFormat = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(pastDeicticExpressionFormat))];
    self.futureDeicticExpressionFormat = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(futureDeicticExpressionFormat))];
    self.approximateQualifierFormat = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(approximateQualifierFormat))];
    self.presentTimeIntervalMargin = [aDecoder decodeDoubleForKey:NSStringFromSelector(@selector(presentTimeIntervalMargin))];
    self.usesAbbreviatedCalendarUnits = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(usesAbbreviatedCalendarUnits))];
    self.usesApproximateQualifier = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(usesApproximateQualifier))];
    self.usesIdiomaticDeicticExpressions = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(usesIdiomaticDeicticExpressions))];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:self.locale forKey:NSStringFromSelector(@selector(locale))];
    [aCoder encodeObject:self.pastDeicticExpression forKey:NSStringFromSelector(@selector(pastDeicticExpression))];
    [aCoder encodeObject:self.presentDeicticExpression forKey:NSStringFromSelector(@selector(presentDeicticExpression))];
    [aCoder encodeObject:self.futureDeicticExpression forKey:NSStringFromSelector(@selector(futureDeicticExpression))];
    [aCoder encodeObject:self.pastDeicticExpressionFormat forKey:NSStringFromSelector(@selector(pastDeicticExpressionFormat))];
    [aCoder encodeObject:self.futureDeicticExpressionFormat forKey:NSStringFromSelector(@selector(futureDeicticExpressionFormat))];
    [aCoder encodeObject:self.approximateQualifierFormat forKey:NSStringFromSelector(@selector(approximateQualifierFormat))];
    [aCoder encodeDouble:self.presentTimeIntervalMargin forKey:NSStringFromSelector(@selector(presentTimeIntervalMargin))];
    [aCoder encodeBool:self.usesAbbreviatedCalendarUnits forKey:NSStringFromSelector(@selector(usesAbbreviatedCalendarUnits))];
    [aCoder encodeBool:self.usesApproximateQualifier forKey:NSStringFromSelector(@selector(usesApproximateQualifier))];
    [aCoder encodeBool:self.usesIdiomaticDeicticExpressions forKey:NSStringFromSelector(@selector(usesIdiomaticDeicticExpressions))];
}

@end
