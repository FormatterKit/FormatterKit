// TTTOrdinalNumberFormatter.m
//
// Copyright (c) 2011–2015 Mattt Thompson (http://mattt.me)
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

#import "TTTOrdinalNumberFormatter.h"

static NSString * const kTTTOrdinalNumberFormatterDefaultOrdinalIndicator = @".";

@implementation TTTOrdinalNumberFormatter
@synthesize ordinalIndicator = _ordinalIndicator;
@synthesize grammaticalGender = _grammaticalGender;
@synthesize grammaticalNumber = _grammaticalNumber;

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    [self setNumberStyle:NSNumberFormatterNoStyle];
    [self setAllowsFloats:NO];
    [self setGeneratesDecimalNumbers:NO];
    [self setRoundingMode:NSNumberFormatterRoundFloor];
    [self setMinimum:@(0)];
    [self setLenient:YES];

    return self;
}

#pragma mark -

- (NSString *)localizedOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    NSString *languageCode = [[self locale] objectForKey:NSLocaleLanguageCode];
    if ([languageCode isEqualToString:@"en"]) {
        return [self enOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"fr"]) {
        return [self frOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"nl"]) {
        return [self nlOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"it"]) {
        return [self itOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"pt"]) {
        return [self ptOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"es"]) {
        return [self esOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"ga"]) {
        return [self gaOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"ja"]) {
        return [self jaOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"zh"]) {
        return [self zhHansOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"ca"]) {
        return [self caOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"sv"]) {
        return [self svOrdinalIndicatorStringFromNumber:number];
    } else {
        return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)caOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    if (self.grammaticalNumber == TTTOrdinalNumberFormatterPlural) {
        if (self.grammaticalGender == TTTOrdinalNumberFormatterFemaleGender) {
            return @"es";
        } else {
            switch ([number integerValue]) {
                case 1:
                    return @"rs";
                case 2:
                    return @"ns";
                case 3:
                    return @"rs";
                case 4:
                    return @"ts";
                default:
                    return @"ns";
            }
        }
    } else {
        if (self.grammaticalGender == TTTOrdinalNumberFormatterFemaleGender) {
            return @"a";
        } else {
            switch ([number integerValue]) {
                case 1:
                    return @"r";
                case 2:
                    return @"n";
                case 3:
                    return @"r";
                case 4:
                    return @"t";
                default:
                    return @"è";
            }
        }
    }
}

- (NSString *)enOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    // If number % 100 is 11, 12, or 13
    if (NSLocationInRange([number integerValue] % 100, NSMakeRange(11, 3))) {
        return @"th";
    }

    switch ([number integerValue] % 10) {
        case 1:
            return @"st";
        case 2:
            return @"nd";
        case 3:
            return @"rd";
        default:
            return @"th";
    }
}

- (NSString *)esOrdinalIndicatorStringFromNumber:(__unused NSNumber *)number {
    switch (self.grammaticalGender) {
        case TTTOrdinalNumberFormatterFemaleGender:
            return @"\u00AA"; // FEMININE ORDINAL INDICATOR
        default:
            return @"\u00BA"; // MASCULINE ORDINAL INDICATOR
    }
}

- (NSString *)frOrdinalIndicatorStringFromNumber:(__unused NSNumber *)number {
    NSString *ordinalIndicator = nil;
    if ([number integerValue] == 1) {
        switch (self.grammaticalGender) {
            case TTTOrdinalNumberFormatterMaleGender:
                ordinalIndicator = @"er";
                break;
            case TTTOrdinalNumberFormatterFemaleGender:
                ordinalIndicator = @"re";
                break;
            default:
                ordinalIndicator = @"er";
                break;
        }
    } else {
        ordinalIndicator = @"e";
    }

    switch (self.grammaticalNumber) {
        case TTTOrdinalNumberFormatterDual:
        case TTTOrdinalNumberFormatterTrial:
        case TTTOrdinalNumberFormatterQuadral:
        case TTTOrdinalNumberFormatterPlural:
            ordinalIndicator = [ordinalIndicator stringByAppendingString:@"s"];
            break;
        default:
            break;
    }

    return ordinalIndicator;
}

- (NSString *)gaOrdinalIndicatorStringFromNumber:(__unused NSNumber *)number {
    return @"\u00FA"; // LATIN SMALL LETTER U WITH ACUTE
}

- (NSString *)itOrdinalIndicatorStringFromNumber:(__unused NSNumber *)number {
    switch (self.grammaticalGender) {
        case TTTOrdinalNumberFormatterMaleGender:
            return @"\u00BA"; // MASCULINE ORDINAL INDICATOR
        case TTTOrdinalNumberFormatterFemaleGender:
            return @"\u00AA"; // FEMININE ORDINAL INDICATOR
        default:
            return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)jaOrdinalIndicatorStringFromNumber:(__unused NSNumber *)number {
    return @"\u756A"; // Unicode Han Character 'to take turns; a turn, a time; to repeat'
}

- (NSString *)nlOrdinalIndicatorStringFromNumber:(__unused NSNumber *)number {
    return @"e";
}

- (NSString *)ptOrdinalIndicatorStringFromNumber:(__unused NSNumber *)number {
    switch (self.grammaticalGender) {
        case TTTOrdinalNumberFormatterMaleGender:
            return @"\u00BA"; // MASCULINE ORDINAL INDICATOR
        case TTTOrdinalNumberFormatterFemaleGender:
            return @"\u00AA"; // FEMININE ORDINAL INDICATOR
        default:
            return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)zhHansOrdinalIndicatorStringFromNumber:(__unused NSNumber *)number {
    return @"\u7B2C"; // Unicode Han Character 'sequence, number; grade, degree'
}

- (NSString *)svOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    // If number % 100 is 11 or 12, ordinals are 11:e and 12:e.
    if (NSLocationInRange([number integerValue] % 100, NSMakeRange(11, 2))) {
        return @":e";
    }
    
    // 1:a, 2:a, 3:e, 4:e and so on. Also, 21:a, 22:a, 23:e ...
    switch ([number integerValue] % 10) {
        case 1:
            return @":a";
        case 2:
            return @":a";
        default:
            return @":e";
    }
}

#pragma mark - NSFormatter

- (NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[NSNumber class]]) {
        return nil;
    }

    NSString *indicator = self.ordinalIndicator;
    if (!indicator) {
        indicator = [self localizedOrdinalIndicatorStringFromNumber:(NSNumber *)anObject];
    }

    NSString *string = nil;
    @synchronized(self) {
        [self setPositivePrefix:nil];
        [self setPositiveSuffix:nil];

        NSString *languageCode = [[self locale] objectForKey:NSLocaleLanguageCode];
        if ([languageCode hasPrefix:@"zh"]) {
            [self setPositivePrefix:indicator];
        } else {
            [self setPositiveSuffix:indicator];
        }

        string = [super stringForObjectValue:anObject];
    }

    return string;
}

- (BOOL)getObjectValue:(out __autoreleasing id *)obj
             forString:(NSString *)string
      errorDescription:(out NSString *__autoreleasing *)error
{
    NSInteger integer = NSNotFound;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanInteger:&integer];

    if (integer != NSNotFound) {
        *obj = @(integer);

        return YES;
    }

    *error = NSLocalizedStringFromTableInBundle(@"String did not contain a valid ordinal number", @"FormatterKit", [NSBundle bundleForClass:[self class]], nil);

    return NO;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    TTTOrdinalNumberFormatter *formatter = [[[self class] allocWithZone:zone] init];

    formatter.ordinalIndicator = [self.ordinalIndicator copyWithZone:zone];
    formatter.grammaticalGender = self.grammaticalGender;
    formatter.grammaticalNumber = self.grammaticalNumber;

    return formatter;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    self.ordinalIndicator = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(ordinalIndicator))];
    self.grammaticalGender = (TTTOrdinalNumberFormatterPredicateGrammaticalGender)[aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(grammaticalGender))];
    self.grammaticalNumber = (TTTOrdinalNumberFormatterPredicateGrammaticalNumber)[aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(grammaticalNumber))];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:self.ordinalIndicator forKey:NSStringFromSelector(@selector(ordinalIndicator))];
    [aCoder encodeInteger:self.grammaticalGender forKey:NSStringFromSelector(@selector(grammaticalGender))];
    [aCoder encodeInteger:self.grammaticalNumber forKey:NSStringFromSelector(@selector(grammaticalNumber))];
}

@end
