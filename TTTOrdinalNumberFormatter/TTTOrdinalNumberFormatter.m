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

#import <objc/runtime.h>
#import "TTTOrdinalNumberFormatter.h"

static NSString * const kTTTOrdinalNumberFormatterDefaultOrdinalIndicator = @".";

@interface TTTOrdinalNumberFormatter ()
@property (nonatomic, copy) NSString *ordinalIndicator;
@property (nonatomic, assign) TTTOrdinalNumberFormatterPredicateGrammaticalGender grammaticalGender;
@property (nonatomic, assign) TTTOrdinalNumberFormatterPredicateGrammaticalNumber grammaticalNumber;

- (NSString *)localizedOrdinalIndicatorStringFromNumber:(NSNumber *)number;
@end

@implementation TTTOrdinalNumberFormatter
@synthesize ordinalIndicator = _ordinalIndicator;
@synthesize grammaticalGender = _grammaticalGender;
@synthesize grammaticalNumber = _grammaticalNumber;

+ (NSArray *)supportedLocales {
    NSMutableArray *supportedLocales = [NSMutableArray array];
    unsigned int count = 0;
    Method *methods = class_copyMethodList(self, &count);
    for (unsigned int idx = 0; idx < count; idx++) {
        NSString *methodName = NSStringFromSelector(method_getName(methods[idx]));
        if ([methodName hasSuffix:@"OrdinalIndicatorStringFromNumber:"]) {
            NSString *localeIdentifier = [methodName substringToIndex:[methodName rangeOfString:@"OrdinalIndicatorStringFromNumber:"].location];
            if (![localeIdentifier isEqualToString:@"localized"]) {
                NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
                [supportedLocales addObject:locale];
                [locale release];
            }
        }
    }
    free(methods);
    return supportedLocales;
}

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

- (void)dealloc {
    [_ordinalIndicator release];
    [super dealloc];
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
    SEL ordinalIndicatorSelector = NSSelectorFromString([languageCode stringByAppendingString:@"OrdinalIndicatorStringFromNumber:"]);
    if ([self respondsToSelector:ordinalIndicatorSelector]) {
        return [self performSelector:ordinalIndicatorSelector withObject:number];
    } else {
        return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)deOrdinalIndicatorStringFromNumber:(NSNumber *)number {
	return @".";
}

- (NSString *)enOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    // If 11, 12, or 13
    if (NSLocationInRange([number integerValue], NSMakeRange(11, 3))) {
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
            return @".o";
        case TTTOrdinalNumberFormatterFemaleGender:
            return @".a";
        default:
            return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)frOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    NSUInteger ulp = [number integerValue] % 10;
    switch (ulp) {
        case 1:
            switch (self.grammaticalGender) {
                case TTTOrdinalNumberFormatterMaleGender:
                    return @"er";
                case TTTOrdinalNumberFormatterFemaleGender:
                    return @"ère";
                default:
                    return @"er";
            }
        default:
            return @"eme";
    }
}

- (NSString *)gaOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"ú";
}

- (NSString *)itOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    switch (self.grammaticalGender) {
        case TTTOrdinalNumberFormatterMaleGender:
            return @".o";
        case TTTOrdinalNumberFormatterFemaleGender:
            return @".a";
        default:
            return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)jaOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"番";
}

- (NSString *)nlOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"e";
}

- (NSString *)ptOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    switch (self.grammaticalGender) {
        case TTTOrdinalNumberFormatterMaleGender:
            return @".o";
        case TTTOrdinalNumberFormatterFemaleGender:
            return @".a";
        default:
            return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)zhOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"第";
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
