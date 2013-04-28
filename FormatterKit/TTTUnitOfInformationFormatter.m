// TTTUnitOfInformationFormatter.m
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me)
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

#import "TTTUnitOfInformationFormatter.h"

static inline NSUInteger TTTNumberOfBitsInUnit(TTTUnitOfInformation unit) {
    switch (unit) {
        case TTTBit:
            return 1;
        case TTTNibble:
            return 4;
        case TTTByte:
            return 8;
        case TTTWord:
            return 16;
        case TTTDoubleWord:
            return 32;
    }
}

static inline double TTTScaleFactorForIECPrefix(TTTUnitPrefix prefix) {
    switch (prefix) {
        case TTTKilo:
            return pow(2.0, 10.0);
        case TTTMega:
            return pow(2.0, 20.0);
        case TTTGiga:
            return pow(2.0, 30.0);
        case TTTTera:
            return pow(2.0, 40.0);
        case TTTPeta:
            return pow(2.0, 50.0);
        case TTTExa:
            return pow(2.0, 60.0);
    }
}

static inline NSString * TTTBitUnitStringForIECPrefix(TTTUnitPrefix prefix) {
    switch (prefix) {
        case TTTKilo:
            return NSLocalizedStringFromTable(@"Kibit", @"FormatterKit", @"Kibibit Unit");
        case TTTMega:
            return NSLocalizedStringFromTable(@"Mibit", @"FormatterKit", @"Mebibit Unit");
        case TTTGiga:
            return NSLocalizedStringFromTable(@"Gibit", @"FormatterKit", @"Gibibit Unit");
        case TTTTera:
            return NSLocalizedStringFromTable(@"Tibit", @"FormatterKit", @"Tebibit Unit");
        case TTTPeta:
            return NSLocalizedStringFromTable(@"Pibit", @"FormatterKit", @"Pebibit Unit");
        case TTTExa:
            return nil;
    }
}

static inline NSString * TTTByteUnitStringForIECPrefix(TTTUnitPrefix prefix) {
    switch (prefix) {
        case TTTKilo:
            return NSLocalizedStringFromTable(@"KiB", @"FormatterKit", @"Kibibyte Unit");
        case TTTMega:
            return NSLocalizedStringFromTable(@"MiB", @"FormatterKit", @"Mebibyte Unit");
        case TTTGiga:
            return NSLocalizedStringFromTable(@"GiB", @"FormatterKit", @"Gibibyte Unit");
        case TTTTera:
            return NSLocalizedStringFromTable(@"TiB", @"FormatterKit", @"Tebibyte Unit");
        case TTTPeta:
            return NSLocalizedStringFromTable(@"PiB", @"FormatterKit", @"Pebibyte Unit");
        case TTTExa:
            return NSLocalizedStringFromTable(@"EiB", @"FormatterKit", @"Exbibyte Unit");
    }
}

static inline double TTTScaleFactorForSIPrefix(TTTUnitPrefix prefix) {
    switch (prefix) {
        case TTTKilo:
            return pow(10.0, 3.0);
        case TTTMega:
            return pow(10.0, 6.0);
        case TTTGiga:
            return pow(10.0, 9.0);
        case TTTTera:
            return pow(10.0, 12.0);
        case TTTPeta:
            return pow(10.0, 15.0);
        case TTTExa:
            return pow(10.0, 18.0);
    }
}

static inline NSString * TTTBitUnitStringForSIPrefix(TTTUnitPrefix prefix) {
    switch (prefix) {
        case TTTKilo:
            return NSLocalizedStringFromTable(@"kbit", @"FormatterKit", @"Kilobit Unit");
        case TTTMega:
            return NSLocalizedStringFromTable(@"Mbit", @"FormatterKit", @"Megabit Unit");
        case TTTGiga:
            return NSLocalizedStringFromTable(@"Gbit", @"FormatterKit", @"Gigabit Unit");
        case TTTTera:
            return NSLocalizedStringFromTable(@"Tbit", @"FormatterKit", @"Terabit Unit");
        case TTTPeta:
            return NSLocalizedStringFromTable(@"Pbit", @"FormatterKit", @"Petabit Unit");
        case TTTExa:
            return nil;
    }
}

static inline NSString * TTTByteUnitStringForSIPrefix(TTTUnitPrefix prefix) {
    switch (prefix) {
        case TTTKilo:
            return NSLocalizedStringFromTable(@"KB", @"FormatterKit", @"Kilobyte Unit");
        case TTTMega:
            return NSLocalizedStringFromTable(@"MB", @"FormatterKit", @"Megabyte Unit");
        case TTTGiga:
            return NSLocalizedStringFromTable(@"GB", @"FormatterKit", @"Gigabyte Unit");
        case TTTTera:
            return NSLocalizedStringFromTable(@"TB", @"FormatterKit", @"Terabyte Unit");
        case TTTPeta:
            return NSLocalizedStringFromTable(@"PB", @"FormatterKit", @"Petabyte Unit");
        case TTTExa:
            return NSLocalizedStringFromTable(@"EB", @"FormatterKit", @"Exabyte Unit");
    }
}

@interface TTTUnitOfInformationFormatter ()
- (double)scaleFactorForPrefix:(TTTUnitPrefix)prefix;
- (TTTUnitPrefix)prefixForInteger:(NSUInteger)value;
@end

@implementation TTTUnitOfInformationFormatter
@synthesize displaysInTermsOfBytes = _displaysInTermsOfBytes;
@synthesize usesIECBinaryPrefixesForCalculation = _usesIECBinaryPrefixesForCalculation;
@synthesize usesIECBinaryPrefixesForDisplay = _usesIECBinaryPrefixesForDisplay;
@synthesize numberFormatter = _numberFormatter;

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    _numberFormatter = [[NSNumberFormatter alloc] init];
    [_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [_numberFormatter setRoundingIncrement:[NSNumber numberWithFloat:0.01f]];

    self.displaysInTermsOfBytes = YES;
    self.usesIECBinaryPrefixesForCalculation = YES;
    self.usesIECBinaryPrefixesForDisplay = NO;

    return self;
}


#pragma mark -

- (double)scaleFactorForPrefix:(TTTUnitPrefix)prefix {
    return self.usesIECBinaryPrefixesForCalculation ? TTTScaleFactorForIECPrefix(prefix) : TTTScaleFactorForSIPrefix(prefix);
}

- (TTTUnitPrefix)prefixForInteger:(NSUInteger)value {
    if ([self scaleFactorForPrefix:TTTExa] < value) {
        return TTTExa;
    } else if ([self scaleFactorForPrefix:TTTPeta] < value) {
        return TTTPeta;
    } else if ([self scaleFactorForPrefix:TTTTera] < value) {
        return TTTTera;
    } else if ([self scaleFactorForPrefix:TTTGiga] < value) {
        return TTTGiga;
    } else if ([self scaleFactorForPrefix:TTTMega] < value) {
        return TTTMega;
    } else {
        return TTTKilo;
    }
}

#pragma mark - NSFormatter

- (NSString *)stringForObjectValue:(id)obj {
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [self stringFromNumberOfBits:(NSNumber *)obj];
    } else {
        return nil;
    }
}

- (NSString *)stringFromNumberOfBits:(NSNumber *)number {
    NSString *unitString = nil;
    double doubleValue = [number doubleValue];

    if (self.displaysInTermsOfBytes) {
        doubleValue /= TTTNumberOfBitsInUnit(TTTByte);
    }

    if (doubleValue < [self scaleFactorForPrefix:TTTKilo]) {
        unitString = self.displaysInTermsOfBytes ? NSLocalizedStringFromTable(@"bytes", @"FormatterKit", @"Byte Unit") : NSLocalizedStringFromTable(@"bits", @"FormatterKit", @"Bit Unit");
    } else {
        TTTUnitPrefix prefix = [self prefixForInteger:[number integerValue]];
        if (self.displaysInTermsOfBytes) {
            unitString = self.usesIECBinaryPrefixesForDisplay ? TTTByteUnitStringForIECPrefix(prefix) : TTTByteUnitStringForSIPrefix(prefix);
        } else {
            unitString = self.usesIECBinaryPrefixesForDisplay ? TTTBitUnitStringForIECPrefix(prefix) : TTTBitUnitStringForSIPrefix(prefix);
        }

        doubleValue /= [self scaleFactorForPrefix:prefix];
    }

    return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"Unit of Information Format String", @"FormatterKit", [NSBundle mainBundle], @"%@ %@", @"#{Value} #{Unit}"), [_numberFormatter stringFromNumber:[NSNumber numberWithDouble:doubleValue]], unitString];
}

- (NSString *)stringFromNumber:(NSNumber *)number
                        ofUnit:(TTTUnitOfInformation)unit
{
    return [self stringFromNumberOfBits:[NSNumber numberWithLongLong:(TTTNumberOfBitsInUnit(unit) * [number integerValue])]];
}

- (NSString *)stringFromNumber:(NSNumber *)number
                        ofUnit:(TTTUnitOfInformation)unit
                    withPrefix:(TTTUnitPrefix)prefix
{
    return [self stringFromNumber:[NSNumber numberWithDouble:([self scaleFactorForPrefix:prefix] * [number integerValue])] ofUnit:unit];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    self.displaysInTermsOfBytes = [aDecoder decodeBoolForKey:@"displaysInTermsOfBytes"];
    self.usesIECBinaryPrefixesForCalculation = [aDecoder decodeBoolForKey:@"usesIECBinaryPrefixesForCalculation"];
    self.usesIECBinaryPrefixesForDisplay = [aDecoder decodeBoolForKey:@"usesIECBinaryPrefixesForDisplay"];

    _numberFormatter = [aDecoder decodeObjectForKey:@"numberFormatter"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];

    [aCoder encodeBool:self.displaysInTermsOfBytes forKey:@"displaysInTermsOfBytes"];
    [aCoder encodeBool:self.usesIECBinaryPrefixesForCalculation forKey:@"usesIECBinaryPrefixesForCalculation"];
    [aCoder encodeBool:self.usesIECBinaryPrefixesForDisplay forKey:@"usesIECBinaryPrefixesForDisplay"];

    [aCoder encodeObject:_numberFormatter forKey:@"numberFormatter"];
}

@end
