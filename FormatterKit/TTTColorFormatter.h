// TTTColorFormatter.h
// 
// Copyright (c) 2013 Mattt Thompson (http://mattt.me)
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
#import <Availability.h>

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#import <UIKit/UIKit.h>

/**
 Instances of `TTTColorFormatter` create string representations of `UIColor` objects, and convert textual representations of colors into `UIColor` objects.
 
 Supported Formats:
 
 - Hexadecimal RGB (`#BADF00D`)
 - RGB (`rgb(100, 60, 20)`)
 - RGBA (`rgba(100, 60, 20, 1.0)`)
 - CMYK (`cmyk(40%, 30%, 10%, 100%)`)
 - HSL (`hsl(300, 60%, 20%)`)
 */
@interface TTTColorFormatter : NSFormatter

///------------------
/// @name Hexadecimal
///------------------

/**
 Returns a hexadecimal representation of the specified color.
 
 @param color The color.
 
 @return A hexadecimal string representation.
 */
- (NSString *)hexadecimalStringFromColor:(UIColor *)color;

/**
 Returns the color represented by the specified hexadecimal string.
 
 @param string The hexadecimal string representation.
 
 @return The color.
 */
- (UIColor *)colorFromHexadecimalString:(NSString *)string;

///----------
/// @name RGB
///----------

/**
 Returns an RGB representation of the specified color.

 @param color The color.

 @return An RGB string representation.
 */
- (NSString *)RGBStringFromColor:(UIColor *)color;

/**
 Returns the color represented by the specified RGB string.

 @param string The RGB string representation.

 @return The color.
 */
- (UIColor *)colorFromRGBString:(NSString *)string;

///-----------
/// @name RGBA
///-----------

/**
 Returns an RGBA representation of the specified color.

 @param color The color.

 @return An RGBA string representation.
 */
- (NSString *)RGBAStringFromColor:(UIColor *)color;

/**
 Returns the color represented by the specified RGBA string.

 @param string The RGBA string representation.

 @return The color.
 */
- (UIColor *)colorFromRGBAString:(NSString *)string;

///-----------
/// @name CMYK
///-----------

/**
 Returns a CMYK representation of the specified color.

 @param color The color.

 @return A CMYK string representation.
 */
- (NSString *)CMYKStringFromColor:(UIColor *)color;

/**
 Returns the color represented by the specified CMYK string.

 @param string The CMYK string representation.

 @return The color.
 */
- (UIColor *)colorFromCMYKString:(NSString *)string;

///----------
/// @name HSL
///----------

/**
 Returns an HSL representation of the specified color.

 @param color The color.

 @return An HSL string representation.
 */
- (NSString *)HSLStringFromColor:(UIColor *)color;

/**
 Returns the color represented by the specified HSL string.

 @param string The HSL string representation.

 @return The color.
 */
- (UIColor *)colorFromHSLString:(NSString *)string;

///--------------------------
/// @name UIColor Declaration
///--------------------------

/**
 Returns a `UIColor` declaration for the specified color.

 @param color The color.

 @return A `UIColor` declaration.
 */
- (NSString *)UIColorDeclarationFromColor:(UIColor *)color;

@end

#endif
