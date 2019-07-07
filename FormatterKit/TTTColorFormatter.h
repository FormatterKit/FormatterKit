// TTTColorFormatter.h
//
// Copyright (c) 2013 Mattt (https://mat.tt)
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


#include "TargetConditionals.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#define TTTColor UIColor

#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#define TTTColor NSColor
#endif



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
- (NSString *)hexadecimalStringFromColor:(TTTColor *)color;

/**
 Returns the color represented by the specified hexadecimal string.

 @param string The hexadecimal string representation.

 @return The color.
 */
- (TTTColor *)colorFromHexadecimalString:(NSString *)string;

///----------
/// @name RGB
///----------

/**
 Returns an RGB representation of the specified color.

 @param color The color.

 @return An RGB string representation.
 */
- (NSString *)RGBStringFromColor:(TTTColor *)color;

/**
 Returns the color represented by the specified RGB string.

 @param string The RGB string representation.

 @return The color.
 */
- (TTTColor *)colorFromRGBString:(NSString *)string;

///-----------
/// @name RGBA
///-----------

/**
 Returns an RGBA representation of the specified color.

 @param color The color.

 @return An RGBA string representation.
 */
- (NSString *)RGBAStringFromColor:(TTTColor *)color;

/**
 Returns the color represented by the specified RGBA string.

 @param string The RGBA string representation.

 @return The color.
 */
- (TTTColor *)colorFromRGBAString:(NSString *)string;

///-----------
/// @name CMYK
///-----------

/**
 Returns a CMYK representation of the specified color.

 @param color The color.

 @return A CMYK string representation.
 */
- (NSString *)CMYKStringFromColor:(TTTColor *)color;

/**
 Returns the color represented by the specified CMYK string.

 @param string The CMYK string representation.

 @return The color.
 */
- (TTTColor *)colorFromCMYKString:(NSString *)string;

///----------
/// @name HSL
///----------

/**
 Returns an HSL representation of the specified color.

 @param color The color.

 @return An HSL string representation.
 */
- (NSString *)HSLStringFromColor:(TTTColor *)color;

/**
 Returns the color represented by the specified HSL string.

 @param string The HSL string representation.

 @return The color.
 */
- (TTTColor *)colorFromHSLString:(NSString *)string;

///--------------------------
/// @name UIColor Declaration
///--------------------------

/**
 Returns a `TTTColor` declaration for the specified color.

 @param color The color.

 @return A `TTTColor` declaration.
 */
- (NSString *)TTTColorDeclarationFromColor:(TTTColor *)color;

#if TARGET_OS_IPHONE
/**
 Returns a `UIColor` declaration for the specified color.

 @param color The color.

 @return A `UIColor` declaration.
 */
- (NSString *)UIColorDeclarationFromColor:(UIColor *)color;

#elif TARGET_OS_MAC

/**
 Returns a `NSColor` declaration for the specified color.

 @param color The color.

 @return A `NSColor` declaration.
 */
- (NSString *)NSColorDeclarationFromColor:(NSColor *)color;

#endif

@end

