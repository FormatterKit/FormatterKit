// TTTArrayFormatter.h
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
 Specifies the style of how array components are joined.
 */
typedef enum {
    TTTArrayFormatterSentenceStyle = 0, // Join with delimiters and a conjunction before the penultimate component.
    TTTArrayFormatterDataStyle,         // Join with delimiters, bound within square brackets like an array literal.
} TTTArrayFormatterStyle;

/**
 Instances of `TTTArrayFormatter` create localized string representations of `NSArray` objects, and convert textual representations of arrays into `NSArray` objects.

 For example, the array `@[@"Russel", @"Spinoza", @"Rawls"]` would be formatted as @"Russel, Spinoza, and Rawls" in English.
 */
@interface TTTArrayFormatter : NSFormatter

/**
 Specifies the style used to format arrays. `TTTArrayFormatterSentenceStyle` by default.
 */
@property (nonatomic, assign) TTTArrayFormatterStyle arrayStyle;

///----------------------------------------
/// @name Configuring Delimiter & Separator
///----------------------------------------

/**
 Specifies the string used to separate delimiters from the next component. " " by default.
 */
@property (nonatomic, copy) NSString *separator;

/**
 Specifies the string used to delimit the components in the array. "," by default.

 @discussion Delimiters are added immediately after each component, before the `separator`.
 */
@property (nonatomic, copy) NSString *delimiter;

/**
 Specifies whether to use a delimiter between the conjunction when applied with the `TTTArrayFormatterSentenceStyle`. `YES` by default.

 @discussion This is also known as the "Oxford Comma".
 */
@property (nonatomic, assign) BOOL usesSerialDelimiter;

///------------------------------
/// @name Configuring Conjunction
///------------------------------

/**
 Specifies the localized string used to join the penultimate and last components together when applied with the `TTTArrayFormatterSentenceStyle`. "and" by default.

 @see usesAbbreviatedConjunction
 */
@property (nonatomic, copy) NSString *conjunction;

/**
 Specifies the abbreviated localized string used to join the penultimate and last components together when applied with the `TTTArrayFormatterSentenceStyle`. "&" by default.

 @see usesAbbreviatedConjunction
 */
@property (nonatomic, copy) NSString *abbreviatedConjunction;

/**
 Specifies whether to use the standard or abbreviated conjunction when applied with the `TTTArrayFormatterSentenceStyle`. `NO` by default.
 */
@property (nonatomic, assign) BOOL usesAbbreviatedConjunction;

///-------------------------
/// @name Converting Objects
///-------------------------

/**
 Returns a string representation of a given array formatted using the default settings in the specified array format style.

 @param anArray The array to be formatted.
 @param style The style used to format the array.
*/
+ (NSString *)localizedStringFromArray:(NSArray *)anArray
                            arrayStyle:(TTTArrayFormatterStyle)style;

/**
 Returns a string representation of a given array formatted using the receiver’s current settings.

 @param anArray The array to format.
 */
- (NSString *)stringFromArray:(NSArray *)anArray;

/**
 Returns a string representation of a given array formatted using the receiver’s current settings along with the substring ranges for the components in the formatted string.

 @param anArray The array to format.
 @param rangeValues Upon return contains an array of NSRange objects that represent the substring ranges of the components in the formatted string.
 */
- (NSString *)stringFromArray:(NSArray *)anArray
           rangesOfComponents:(NSArray * __autoreleasing *)rangeValues;

/**
 Returns an array representation of a given string interpreted using the receiver’s current settings.

 @param aString The string to parse.
 */
- (NSArray *)arrayFromString:(NSString *)aString;

@end
