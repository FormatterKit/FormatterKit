// TTTUnitOfInformationFormatter.h
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

#import <Foundation/Foundation.h>

/**
 Defines units of information.
 */
typedef NS_ENUM(NSUInteger, TTTUnitOfInformation) {
    TTTBit,
    TTTNibble,
    TTTByte,
    TTTWord,
    TTTDoubleWord
};

/**
 Defines unit prefixes.
 */
typedef NS_ENUM(NSUInteger, TTTUnitPrefix) {
    TTTKilo,
    TTTMega,
    TTTGiga,
    TTTTera,
    TTTPeta,
    TTTExa,
};

/**
 Instances of `TTTUnitOfInformationFormatter` create localized string representations of quantities of information.

 For example, the the value 1080 bytes could be formatted as "1.08 KB" or "8.46 Kibit".

 @discussion By default, `TTTUnitOfInformationFormatter` uses IEC binary prefixes to calculate (i.e. 1 kilobit = 1,024 bits rather than 1,000 bits), but displays in terms of standard prefixes (i.e. kbit rather than kibit). See http://en.wikipedia.org/wiki/Binary_prefix#IEC_prefixes for more informaion about IEC prefixes. Additionally.
 */
@interface TTTUnitOfInformationFormatter : NSFormatter <NSCoding>

/**
 Specifies the `NSNumberFormatter` object used to format numeric values in all formatted strings. By default, this uses the `NSNumberFormatterDecimalStyle` number style, and sets a rounding increment of `0.01f`.
 */
@property (nonatomic, readonly) NSNumberFormatter *numberFormatter;

///-------------------------------
/// @name Configuring Use of Bytes
///-------------------------------

/**
 Specifies whether to display units of information in terms of bytes, as opposed to bits. `YES` by default.
 */
@property (nonatomic, assign) BOOL displaysInTermsOfBytes;

///--------------------------------------
/// @name Configuring IEC Binary Prefixes
///--------------------------------------

/**
 Specifies whether to use IEC binary prefixes for calculation. `YES` by default.
 */
@property (nonatomic, assign) BOOL usesIECBinaryPrefixesForCalculation;

/**
 Specifies whether to use IEC binary prefixes for display. `NO` by default.
 */
@property (nonatomic, assign) BOOL usesIECBinaryPrefixesForDisplay;

///-------------------------
/// @name Converting Objects
///-------------------------

/**
 Returns a string representation of a given number of bits formatted using the receiver’s current settings.

 @param numberOfBits The number of bits to format.
 */
- (NSString *)stringFromNumberOfBits:(NSNumber *)numberOfBits;

/**
 Returns a string representation of a given number of a specified unit of information formatted using the receiver’s current settings.

 @param number The number of specified units for format.
 @param unit The number unit.
 */
- (NSString *)stringFromNumber:(NSNumber *)number
                        ofUnit:(TTTUnitOfInformation)unit;

/**
 Returns a string representation of a given number of a specified unit of information with a particular prefix formatted using the receiver’s current settings.

 @param number The number of specified units for format.
 @param unit The number unit.
 @param prefix The unit prefix.
 */
- (NSString *)stringFromNumber:(NSNumber *)number
                        ofUnit:(TTTUnitOfInformation)unit
                    withPrefix:(TTTUnitPrefix)prefix;

@end
