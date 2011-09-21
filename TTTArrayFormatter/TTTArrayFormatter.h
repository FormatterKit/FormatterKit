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

typedef enum {
    TTTArrayFormatterSentenceStyle = 0,
    TTTArrayFormatterDataStyle,
} TTTArrayFormatterStyle;

@interface TTTArrayFormatter : NSFormatter {
@private
    TTTArrayFormatterStyle _arrayStyle;
    NSString *_delimiter;
    NSString *_separator;
    NSString *_conjunction;
    NSString *_abbreviatedConjunction;
    BOOL _usesAbbreviatedConjunction;
    BOOL _usesSerialDelimiter;
}

- (NSString *)stringFromArray:(NSArray *)anArray;
- (NSString *)stringFromArray:(NSArray *)anArray rangesOfComponents:(NSArray **)rangeValues;
- (NSArray *)arrayFromString:(NSString *)aString;
+ (NSString *)localizedStringFromArray:(NSArray *)anArray arrayStyle:(TTTArrayFormatterStyle)style;

- (TTTArrayFormatterStyle)arrayStyle;
- (void)setArrayStyle:(TTTArrayFormatterStyle)style;

- (NSString *)delimiter;
- (void)setDelimiter:(NSString *)aDelimiter;

- (NSString *)separator;
- (void)setSeparator:(NSString *)aSeparator;

- (NSString *)conjunction;
- (void)setConjunction:(NSString *)aConjunction;

- (NSString *)abbreviatedConjunction;
- (void)setAbbreviatedConjunction:(NSString *)anAbbreviatedConjunction;

- (BOOL)usesAbbreviatedConjunction;
- (void)setUsesAbbreviatedConjunction:(BOOL)flag;

- (BOOL)usesSerialDelimiter;
- (void)setUsesSerialDelimiter:(BOOL)flag;

@end
