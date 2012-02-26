// TTTTimeIntervalFormatter.m
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

#import "TTTTimeIntervalFormatter.h"

static inline NSCalendarUnit NSCalendarUnitFromString(NSString *string) {
    if ([string isEqualToString:@"year"]) {
        return NSYearCalendarUnit;
    } else if ([string isEqualToString:@"month"]) {
        return NSMonthCalendarUnit;
    } else if ([string isEqualToString:@"week"]) {
        return NSWeekCalendarUnit;
    } else if ([string isEqualToString:@"day"]) {
        return NSDayCalendarUnit;
    } else if ([string isEqualToString:@"hour"]) {
        return NSHourCalendarUnit;
    } else if ([string isEqualToString:@"minute"]) {
        return NSMinuteCalendarUnit;
    } if ([string isEqualToString:@"second"]) {
        return NSSecondCalendarUnit;
    }
    
    return NSUndefinedDateComponent;
}

@interface TTTTimeIntervalFormatter ()
@property (readwrite, nonatomic, retain) NSLocale *locale;
@property (readwrite, nonatomic, copy) NSString *pastDeicticExpression;
@property (readwrite, nonatomic, copy) NSString *presentDeicticExpression;
@property (readwrite, nonatomic, copy) NSString *futureDeicticExpression;
@property (readwrite, nonatomic, copy) NSString *deicticExpressionFormat;
@property (readwrite, nonatomic, copy) NSString *approximateQualifierFormat;
@property (readwrite, nonatomic, assign) NSTimeInterval presentTimeIntervalMargin;
@property (readwrite, nonatomic, assign) BOOL usesAbbreviatedCalendarUnits;
@property (readwrite, nonatomic, assign) BOOL usesApproximateQualifier;
@property (readwrite, nonatomic, assign) BOOL usesIdiomaticDeicticExpressions;

- (NSString *)localizedStringForNumber:(NSUInteger)number ofCalendarUnit:(NSCalendarUnit)unit;

- (NSString *)localizedIdiomaticDeicticExpressionForComponents:(NSDateComponents *)componenets;
- (NSString *)enRelativeDateStringForComponents:(NSDateComponents *)components;

@end

@implementation TTTTimeIntervalFormatter
@synthesize locale = _locale;
@synthesize pastDeicticExpression = _pastDeicticExpression;
@synthesize presentDeicticExpression = _presentDeicticExpression;
@synthesize futureDeicticExpression = _futureDeicticExpression;
@synthesize deicticExpressionFormat = _deicticExpressionFormat;
@synthesize approximateQualifierFormat = _approximateQualifierFormat;
@synthesize presentTimeIntervalMargin = _presentTimeIntervalMargin;
@synthesize usesAbbreviatedCalendarUnits = _usesAbbreviatedCalendarUnits;
@synthesize usesApproximateQualifier = _usesApproximateQualifier;
@synthesize usesIdiomaticDeicticExpressions = _usesIdiomaticDeicticExpressions;

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.pastDeicticExpression = NSLocalizedString(@"ago", @"Past Deictic Expression");
    self.presentDeicticExpression = NSLocalizedString(@"just now", @"Present Deictic Expression");
    self.futureDeicticExpression = NSLocalizedString(@"from now", @"Future Deictic Expression");
    
    self.deicticExpressionFormat = NSLocalizedString(@"%@ %@", @"Deictic Expression Format (#{Time} #{Ago/From Now}");
    self.approximateQualifierFormat = NSLocalizedString(@"about %@", @"Approximate Qualifier Format");
    
    self.presentTimeIntervalMargin = 1;
        
    return self;
}

- (void)dealloc {
    [_locale release];
    [_pastDeicticExpression release];
    [_presentDeicticExpression release];
    [_futureDeicticExpression release];
    [_deicticExpressionFormat release];
    [_approximateQualifierFormat release];
    [_approximateQualifierFormat release];
    [super dealloc];
}

- (NSString *)stringForTimeInterval:(NSTimeInterval)seconds {
    return [self stringForTimeIntervalFromDate:[NSDate date] toDate:[NSDate dateWithTimeIntervalSinceNow:seconds]];
}

- (NSString *)stringForTimeIntervalFromDate:(NSDate *)startingDate toDate:(NSDate *)resultDate {
    NSTimeInterval seconds = [startingDate timeIntervalSinceDate:resultDate];
    if (fabs(seconds) < self.presentTimeIntervalMargin) {
        return self.presentDeicticExpression;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:startingDate toDate:resultDate options:0];
    
    if (self.usesIdiomaticDeicticExpressions) {
        NSString *idiomaticDeicticExpression = [self localizedIdiomaticDeicticExpressionForComponents:components];
        if (idiomaticDeicticExpression) {
            return idiomaticDeicticExpression;
        }
    }
    
    NSString *string = nil;
    BOOL isApproximate = NO;
    for (NSString *unitName in [NSArray arrayWithObjects:@"year", @"month", @"week", @"day", @"hour", @"minute", @"second", nil]) {
        NSNumber *number = [NSNumber numberWithInteger:abs([[components valueForKey:unitName] integerValue])];
        if ([number integerValue]) {
            if (!string) {
                string = [NSString stringWithFormat:@"%@ %@", number, [self localizedStringForNumber:[number integerValue] ofCalendarUnit:NSCalendarUnitFromString(unitName)]];
            } else {
                isApproximate = YES;
            }
        }
    }
    
    if (string) {
        if (seconds > 0) {
            string = [NSString stringWithFormat:self.deicticExpressionFormat, string, self.pastDeicticExpression];
        } else {
            string = [NSString stringWithFormat:self.deicticExpressionFormat, string, self.futureDeicticExpression];
        }
        
        if (isApproximate && self.usesApproximateQualifier) {
            string = [NSString stringWithFormat:self.approximateQualifierFormat, string]; 
        }
    }
    
    return string;
}

- (NSString *)localizedStringForNumber:(NSUInteger)number ofCalendarUnit:(NSCalendarUnit)unit {
    BOOL singular = (number == 1);
    
    if (self.usesAbbreviatedCalendarUnits) {
        switch (unit) {
            case NSYearCalendarUnit:
                return singular ? NSLocalizedString(@"yr.", @"Year Unit (Singular, Abbreviated)") : NSLocalizedString(@"yrs.", @"Year Unit (Plural, Abbreviated)");                
            case NSMonthCalendarUnit:
                return singular ? NSLocalizedString(@"mo.", @"Month Unit (Singular, Abbreviated)") : NSLocalizedString(@"mos.", @"Month Unit (Plural, Abbreviated)");
            case NSWeekCalendarUnit:
                return singular ? NSLocalizedString(@"wk.", @"Week Unit (Singular, Abbreviated)") : NSLocalizedString(@"wks.", @"Week Unit (Plural, Abbreviated)");
            case NSDayCalendarUnit:
                return singular ? NSLocalizedString(@"day", @"Day Unit (Singular, Abbreviated)") : NSLocalizedString(@"days", @"Day Unit (Plural, Abbreviated)");
            case NSHourCalendarUnit:
                return singular ? NSLocalizedString(@"hr", @"Hour Unit (Singular, Abbreviated)") : NSLocalizedString(@"hrs.", @"Hour Unit (Plural, Abbreviated)");
            case NSMinuteCalendarUnit:
                return singular ? NSLocalizedString(@"min.", @"Minute Unit (Singular, Abbreviated)") : NSLocalizedString(@"mins.", @"Minute Unit (Plural, Abbreviated)");
            case NSSecondCalendarUnit:
                return singular ? NSLocalizedString(@"s.", @"Second Unit (Singular, Abbreviated)") : NSLocalizedString(@"s.", @"Second Unit (Plural, Abbreviated)");
        }
    } else {
        switch (unit) {
            case NSYearCalendarUnit:
                return singular ? NSLocalizedString(@"year", @"Year Unit (Singular¥)") : NSLocalizedString(@"years", @"Year Unit (Plural)");                
            case NSMonthCalendarUnit:
                return singular ? NSLocalizedString(@"month", @"Month Unit (Singular)") : NSLocalizedString(@"months", @"Month Unit (Plural)");
            case NSWeekCalendarUnit:
                return singular ? NSLocalizedString(@"week", @"Week Unit (Singular)") : NSLocalizedString(@"weeks", @"Week Unit (Plural)");
            case NSDayCalendarUnit:
                return singular ? NSLocalizedString(@"day", @"Day Unit (Singular)") : NSLocalizedString(@"days", @"Day Unit (Plural)");
            case NSHourCalendarUnit:
                return singular ? NSLocalizedString(@"hour", @"Hour Unit (Singular)") : NSLocalizedString(@"hours", @"Hour Unit (Plural)");
            case NSMinuteCalendarUnit:
                return singular ? NSLocalizedString(@"minute", @"Minute Unit (Singular)") : NSLocalizedString(@"minutes", @"Minute Unit (Plural)");
            case NSSecondCalendarUnit:
                return singular ? NSLocalizedString(@"second", @"Second Unit (Singular)") : NSLocalizedString(@"seconds", @"Second Unit (Plural)");
        }
    }
    
    return nil;
}

#pragma mark -

- (NSString *)localizedIdiomaticDeicticExpressionForComponents:(NSDateComponents *)components {
    NSString *languageCode = [[self locale] objectForKey:NSLocaleLanguageCode];
    if ([languageCode isEqualToString:@"en"]) {
        return [self enRelativeDateStringForComponents:components];
    }
    
    return nil;
}
    
- (NSString *)enRelativeDateStringForComponents:(NSDateComponents *)components {
    if ([components year] == -1) {
        return @"last year";
    } else if ([components month] == -1) {
        return @"last month";
    } else if ([components week] == -1) {
        return @"last week";
    } else if ([components day] == -1) {
        return @"yesterday";
    }
    
    if ([components year] == 1) {
        return @"next year";
    } else if ([components month] == 1) {
        return @"next month";
    } else if ([components week] == 1) {
        return @"next week";
    } else if ([components day] == 1) {
        return @"tomorrow";
    }
    
    return nil;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    self.locale = [aDecoder decodeObjectForKey:@"locale"];
    self.pastDeicticExpression = [aDecoder decodeObjectForKey:@"pastDeicticExpression"];
    self.presentDeicticExpression = [aDecoder decodeObjectForKey:@"presentDeicticExpression"];
    self.futureDeicticExpression = [aDecoder decodeObjectForKey:@"futureDeicticExpression"];
    self.deicticExpressionFormat = [aDecoder decodeObjectForKey:@"deicticExpressionFormat"];
    self.approximateQualifierFormat = [aDecoder decodeObjectForKey:@"approximateQualifierFormat"];
    self.presentTimeIntervalMargin = [aDecoder decodeDoubleForKey:@"presentTimeIntervalMargin"];
    self.usesAbbreviatedCalendarUnits = [aDecoder decodeBoolForKey:@"usesAbbreviatedCalendarUnits"];
    self.usesApproximateQualifier = [aDecoder decodeBoolForKey:@"usesApproximateQualifier"];
    self.usesIdiomaticDeicticExpressions = [aDecoder decodeBoolForKey:@"usesIdiomaticDeicticExpressions"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.locale forKey:@"locale"];
    [aCoder encodeObject:self.pastDeicticExpression forKey:@"pastDeicticExpression"];
    [aCoder encodeObject:self.presentDeicticExpression forKey:@"presentDeicticExpression"];
    [aCoder encodeObject:self.futureDeicticExpression forKey:@"futureDeicticExpression"];
    [aCoder encodeObject:self.deicticExpressionFormat forKey:@"deicticExpressionFormat"];
    [aCoder encodeObject:self.approximateQualifierFormat forKey:@"approximateQualifierFormat"];
    [aCoder encodeDouble:self.presentTimeIntervalMargin forKey:@"presentTimeIntervalMargin"];
    [aCoder encodeBool:self.usesAbbreviatedCalendarUnits forKey:@"usesAbbreviatedCalendarUnits"];
    [aCoder encodeBool:self.usesApproximateQualifier forKey:@"usesApproximateQualifier"];
    [aCoder encodeBool:self.usesIdiomaticDeicticExpressions forKey:@"usesIdiomaticDeicticExpressions"];
}

@end
