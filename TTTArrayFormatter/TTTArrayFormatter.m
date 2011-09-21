// TTTArrayFormatter.m
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

#import "TTTArrayFormatter.h"

@interface TTTArrayFormatter ()
@property (readwrite, nonatomic, assign) TTTArrayFormatterStyle arrayStyle;
@property (readwrite, nonatomic, copy) NSString *delimiter;
@property (readwrite, nonatomic, copy) NSString *separator;
@property (readwrite, nonatomic, copy) NSString *conjunction;
@property (readwrite, nonatomic, copy) NSString *abbreviatedConjunction;
@property (readwrite, nonatomic, assign) BOOL usesAbbreviatedConjunction;
@property (readwrite, nonatomic, assign) BOOL usesSerialDelimiter;
@end

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
    
    self.delimiter = NSLocalizedString(@",", @"List delimiter");
    self.separator = NSLocalizedString(@" ", @"List separator");
    self.conjunction = NSLocalizedString(@"and", @"List conjunction");
    self.abbreviatedConjunction = NSLocalizedString(@"&", nil);
    self.usesAbbreviatedConjunction = NO;
    self.usesSerialDelimiter = YES;
    
    return self;
}

- (void)dealloc {
    [_delimiter release];
    [_separator release];
    [_conjunction release];
    [_abbreviatedConjunction release];
    [super dealloc];
}

- (NSString *)stringFromArray:(NSArray *)anArray {
    return [self stringFromArray:anArray rangesOfComponents:nil];
}

- (NSString *)stringFromArray:(NSArray *)anArray rangesOfComponents:(NSArray **)rangeValues {
    NSMutableString *mutableString = [NSMutableString string];
    NSMutableArray *componentRanges = [NSMutableArray arrayWithCapacity:[anArray count]];
    for (NSUInteger idx = 0; idx < [anArray count]; idx++) {
        NSString *component = [[anArray objectAtIndex:idx] description];
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

+ (NSString *)localizedStringFromArray:(NSArray *)anArray arrayStyle:(TTTArrayFormatterStyle)style {
    TTTArrayFormatter *formatter = [[[TTTArrayFormatter alloc] init] autorelease];
    [formatter setArrayStyle:style];
    
    return [formatter stringFromArray:anArray];
}

#pragma mark NSFormatter

- (NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    return [self stringFromArray:anObject rangesOfComponents:nil];
}

- (BOOL)getObjectValue:(id *)obj forString:(NSString *)string errorDescription:(NSString **)error {
    BOOL returnValue = NO;
    NSMutableArray *components = nil;
    
    if (string) {
        components = [[[string componentsSeparatedByString:self.delimiter] mutableCopy] autorelease];
        NSMutableString *lastComponent = [[(NSString *)[components lastObject] mutableCopy] autorelease];
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
                *error = NSLocalizedString(@"Couldn’t convert to NSArray", @"Error converting to NSArray");   
            }
        }
    }
    
    return returnValue;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    self.arrayStyle = [aDecoder decodeIntegerForKey:@"arrayStyle"];
    self.delimiter = [aDecoder decodeObjectForKey:@"delimiter"];
    self.separator = [aDecoder decodeObjectForKey:@"separator"];
    self.conjunction = [aDecoder decodeObjectForKey:@"conjunction"];
    self.abbreviatedConjunction = [aDecoder decodeObjectForKey:@"abbreviatedConjunction"];
    self.usesAbbreviatedConjunction = [aDecoder decodeBoolForKey:@"usesAbbreviatedConjunction"];
    self.usesSerialDelimiter = [aDecoder decodeBoolForKey:@"usesSerialDelimiter"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInteger:self.arrayStyle forKey:@"arrayStyle"];
    [aCoder encodeObject:self.delimiter forKey:@"delimiter"];
    [aCoder encodeObject:self.separator forKey:@"separator"];
    [aCoder encodeObject:self.conjunction forKey:@"conjunction"];
    [aCoder encodeObject:self.abbreviatedConjunction forKey:@"abbreviatedConjunction"];
    [aCoder encodeBool:self.usesAbbreviatedConjunction forKey:@"usesAbbreviatedConjunction"];
    [aCoder encodeBool:self.usesSerialDelimiter forKey:@"usesSerialDelimiter"];
}

@end
