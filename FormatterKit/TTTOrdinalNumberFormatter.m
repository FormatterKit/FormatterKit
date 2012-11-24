// TTTOrdinalNumberFormatter.m
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

#import "TTTOrdinalNumberFormatter.h"

static NSString * const kTTTOrdinalNumberFormatterDefaultOrdinalIndicator = @".";

@interface TTTOrdinalNumberFormatter ()
- (NSString *)localizedOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)deOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)enOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)esOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)frOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)gaOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)itOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)jaOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)nlOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)ptOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)zhHansOrdinalIndicatorStringFromNumber:(NSNumber *)number;
@end

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
    [self setMinimum:[NSNumber numberWithInteger:0]];
    [self setLenient:YES];

    return self;
}

- (NSString *)stringFromNumber:(NSNumber *)number {
    NSString *indicator = self.ordinalIndicator;
    if (!indicator) {
        indicator = [self localizedOrdinalIndicatorStringFromNumber:number];
    }

    [self setPositivePrefix:nil];
    [self setPositiveSuffix:nil];

    NSString *languageCode = [[self locale] objectForKey:NSLocaleLanguageCode];
    if ([languageCode isEqualToString:@"zh"]) {
        [self setPositivePrefix:indicator];
    } else {
        [self setPositiveSuffix:indicator];
    }

    return [super stringFromNumber:number];
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
    } else {
        return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)deOrdinalIndicatorStringFromNumber:(NSNumber *)number {
	return @".";
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

- (NSString *)esOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    switch (self.grammaticalGender) {
        case TTTOrdinalNumberFormatterMaleGender:
            return @"\u00BA"; // MASCULINE ORDINAL INDICATOR
        case TTTOrdinalNumberFormatterFemaleGender:
            return @"\u00AA"; // FEMININE ORDINAL INDICATOR
        default:
            return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)frOrdinalIndicatorStringFromNumber:(NSNumber *)number {
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
    }
    else {
        ordinalIndicator = @"e";
    }

    if (self.grammaticalNumber == TTTOrdinalNumberFormatterDual || self.grammaticalNumber == TTTOrdinalNumberFormatterTrial || self.grammaticalNumber == TTTOrdinalNumberFormatterQuadral || self.grammaticalNumber == TTTOrdinalNumberFormatterPlural) {
        ordinalIndicator = [ordinalIndicator stringByAppendingString:@"s"];
    }

    return ordinalIndicator;
}

- (NSString *)gaOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"\u00fa"; // LATIN SMALL LETTER U WITH ACUTE
}

- (NSString *)itOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    switch (self.grammaticalGender) {
        case TTTOrdinalNumberFormatterMaleGender:
            return @"\u00BA"; // MASCULINE ORDINAL INDICATOR
        case TTTOrdinalNumberFormatterFemaleGender:
            return @"\u00AA"; // FEMININE ORDINAL INDICATOR
        default:
            return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)jaOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"\u756a";
}

- (NSString *)nlOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"e";
}

- (NSString *)ptOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    switch (self.grammaticalGender) {
        case TTTOrdinalNumberFormatterMaleGender:
            return @"\u00BA"; // MASCULINE ORDINAL INDICATOR
        case TTTOrdinalNumberFormatterFemaleGender:
            return @"\u00AA"; // FEMININE ORDINAL INDICATOR
        default:
            return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)zhHansOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"\u7b2c";
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    self.ordinalIndicator = [aDecoder decodeObjectForKey:@"ordinalIndicator"];
    self.grammaticalGender = [aDecoder decodeIntegerForKey:@"grammaticalGender"];
    self.grammaticalNumber = [aDecoder decodeIntegerForKey:@"grammaticalNumber"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:self.ordinalIndicator forKey:@"ordinalIndicator"];
    [aCoder encodeInteger:self.grammaticalGender forKey:@"grammaticalGender"];
    [aCoder encodeInteger:self.grammaticalNumber forKey:@"grammaticalNumber"];
}

@end
