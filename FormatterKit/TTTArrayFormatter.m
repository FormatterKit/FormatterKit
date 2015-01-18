// TTTArrayFormatter.m
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

#import "TTTArrayFormatter.h"

@implementation TTTArrayFormatter
@synthesize arrayStyle = _arrayStyle;
@synthesize delimiter = _delimiter;
@synthesize separator = _separator;
@synthesize conjunction = _conjunction;
@synthesize abbreviatedConjunction = _abbreviatedConjunction;
@synthesize usesAbbreviatedConjunction = _usesAbbreviatedConjunction;
@synthesize usesSerialDelimiter = _usesSerialDelimiter;

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.delimiter = NSLocalizedStringFromTable(@",", @"FormatterKit", @"List delimiter");
    self.separator = NSLocalizedStringFromTable(@" ", @"FormatterKit", @"List separator");
    self.conjunction = NSLocalizedStringFromTable(@"and", @"FormatterKit", @"List conjunction");
    self.abbreviatedConjunction = NSLocalizedStringFromTable(@"&", @"FormatterKit", nil);
    self.usesAbbreviatedConjunction = NO;
    self.usesSerialDelimiter = YES;

    return self;
}

+ (NSString *)localizedStringFromArray:(NSArray *)anArray
                            arrayStyle:(TTTArrayFormatterStyle)style
{
    TTTArrayFormatter *formatter = [[TTTArrayFormatter alloc] init];
    [formatter setArrayStyle:style];

    return [formatter stringFromArray:anArray];
}

- (NSString *)stringFromArray:(NSArray *)anArray {
    return [self stringFromArray:anArray rangesOfComponents:nil];
}

- (NSString *)stringFromArray:(NSArray *)anArray
           rangesOfComponents:(NSArray * __autoreleasing *)rangeValues
{
    NSMutableString *mutableString = [NSMutableString string];
    NSMutableArray *componentRanges = [NSMutableArray arrayWithCapacity:[anArray count]];
    for (NSUInteger idx = 0; idx < [anArray count]; idx++) {
        NSString *component = [anArray[idx] description];
        if (!component) {
            continue;
        }

        BOOL isFirstComponent = (idx == 0);
        BOOL isLastComponent = (idx == [anArray count] - 1);
        BOOL isPenultimateComponent = (idx == [anArray count] - 2);
        if (self.conjunction && self.arrayStyle != TTTArrayFormatterDataStyle && (isLastComponent && !isFirstComponent)) {
            [mutableString appendString:self.usesAbbreviatedConjunction ? self.abbreviatedConjunction : self.conjunction];
            [mutableString appendString:self.separator];
        }

        NSRange componentRange = NSMakeRange([mutableString length], [component length]);
        [componentRanges addObject:[NSValue valueWithRange:componentRange]];

        [mutableString appendString:component];

        if (self.arrayStyle == TTTArrayFormatterDataStyle) {
            if (!isLastComponent) {
                [mutableString appendString:self.delimiter];
                [mutableString appendString:self.separator];
            }
        } else if (self.delimiter && [anArray count] > 2 && !isLastComponent) {
            if (isPenultimateComponent && !self.usesSerialDelimiter) {
                [mutableString appendString:self.separator];
            } else {
                [mutableString appendString:self.delimiter];
                [mutableString appendString:self.separator];
            }
        } else if ([anArray count] == 2 && !isLastComponent) {
            [mutableString appendString:self.separator];
        }
    }

    if (rangeValues) {
        *rangeValues = [NSArray arrayWithArray:componentRanges];
    }

    return [NSString stringWithString:mutableString];
}

- (NSArray *)arrayFromString:(NSString *)aString {
    NSArray *array = nil;
    [self getObjectValue:&array forString:aString errorDescription:nil];

    return array;
}

#pragma mark - NSFormatter

- (NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[NSArray class]]) {
        return nil;
    }

    return [self stringFromArray:(NSArray *)anObject rangesOfComponents:nil];
}

- (BOOL)getObjectValue:(out __autoreleasing id *)obj
             forString:(NSString *)string
      errorDescription:(out NSString *__autoreleasing *)error
{
    BOOL returnValue = NO;
    NSMutableArray *components = nil;

    if (string) {
        components = [[string componentsSeparatedByString:self.delimiter] mutableCopy];
        NSMutableString *lastComponent = [(NSString *)[components lastObject] mutableCopy];
        NSRange lastComponentConjunctionRange = [lastComponent rangeOfString:self.conjunction];
        if (lastComponentConjunctionRange.location != NSNotFound) {
            [lastComponent replaceCharactersInRange:lastComponentConjunctionRange withString:self.delimiter];
            [components removeLastObject];
            [components addObjectsFromArray:[lastComponent componentsSeparatedByString:self.delimiter]];
        }

        if (components) {
            *obj = [NSArray arrayWithArray:components];
        } else {
            if (error) {
                *error = NSLocalizedStringFromTable(@"Couldn’t convert to NSArray", @"FormatterKit", @"Error converting to NSArray");
            }
        }
    }

    return returnValue;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    TTTArrayFormatter *formatter = [[[self class] allocWithZone:zone] init];

    formatter.arrayStyle = self.arrayStyle;
    formatter.delimiter = [self.delimiter copyWithZone:zone];
    formatter.separator = [self.separator copyWithZone:zone];
    formatter.conjunction = [self.conjunction copyWithZone:zone];
    formatter.abbreviatedConjunction = [self.abbreviatedConjunction copyWithZone:zone];
    formatter.usesAbbreviatedConjunction = self.usesAbbreviatedConjunction;
    formatter.usesSerialDelimiter = self.usesSerialDelimiter;

    return formatter;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    self.arrayStyle = (TTTArrayFormatterStyle)[aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(arrayStyle))];
    self.delimiter = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(delimiter))];
    self.separator = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(separator))];
    self.conjunction = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(conjunction))];
    self.abbreviatedConjunction = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(abbreviatedConjunction))];
    self.usesAbbreviatedConjunction = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(usesAbbreviatedConjunction))];
    self.usesSerialDelimiter = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(usesSerialDelimiter))];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];

    [aCoder encodeInteger:self.arrayStyle forKey:NSStringFromSelector(@selector(arrayStyle))];
    [aCoder encodeObject:self.delimiter forKey:NSStringFromSelector(@selector(delimiter))];
    [aCoder encodeObject:self.separator forKey:NSStringFromSelector(@selector(separator))];
    [aCoder encodeObject:self.conjunction forKey:NSStringFromSelector(@selector(conjunction))];
    [aCoder encodeObject:self.abbreviatedConjunction forKey:NSStringFromSelector(@selector(abbreviatedConjunction))];
    [aCoder encodeBool:self.usesAbbreviatedConjunction forKey:NSStringFromSelector(@selector(usesAbbreviatedConjunction))];
    [aCoder encodeBool:self.usesSerialDelimiter forKey:NSStringFromSelector(@selector(usesSerialDelimiter))];
}

@end
