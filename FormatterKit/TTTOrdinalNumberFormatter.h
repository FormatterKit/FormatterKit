// TTTOrdinalNumberFormatter.h
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
 Specifies the grammatical gender of the word conjugated by the ordinal number.
 */
typedef NS_ENUM(NSUInteger, TTTOrdinalNumberFormatterPredicateGrammaticalGender) {
    TTTOrdinalNumberFormatterMaleGender     = 1,
    TTTOrdinalNumberFormatterFemaleGender   = 2,
    TTTOrdinalNumberFormatterNeuterGender   = 3,
};

/**
 Specifies the grammatical number of the word conjugated by the ordinal number.
 */
typedef NS_ENUM(NSUInteger, TTTOrdinalNumberFormatterPredicateGrammaticalNumber) {
    TTTOrdinalNumberFormatterSingular       = 1,
    TTTOrdinalNumberFormatterDual           = 2,
    TTTOrdinalNumberFormatterTrial          = 3,
    TTTOrdinalNumberFormatterQuadral        = 4,
    TTTOrdinalNumberFormatterSingularCollective,
    TTTOrdinalNumberFormatterPlural,
};

/**
 Instances of `TTTOrdinalNumberFormatter` create localized ordinal string representations of `NSNumber` objects.

 Each instance has a default number style of `NSNumberFormatterNoStyle`, does not allow floats nor generates decimal numbers, has a rounding mode of `NSNumberFormatterRoundFloor`, a minimum value of @0, and is has leniency turned on.

 For example, the numbers `@1`, `@2`, and `@3` would be formatted as `@"1st"`, `@"2nd"`, and `@"3rd"` in English.
 */
@interface TTTOrdinalNumberFormatter : NSNumberFormatter

/**
 When specified, this overrides the indicator determined by the formatter. `nil` by default.
 */
@property (nonatomic, copy) NSString *ordinalIndicator;

/**
 Specifies the grammatical gender of the word conjugated by the ordinal number.
 */
@property (nonatomic, assign) TTTOrdinalNumberFormatterPredicateGrammaticalGender grammaticalGender;

/**
 Specifies the grammatical number of the word conjugated by the ordinal number.
 */
@property (nonatomic, assign) TTTOrdinalNumberFormatterPredicateGrammaticalNumber grammaticalNumber;

@end
