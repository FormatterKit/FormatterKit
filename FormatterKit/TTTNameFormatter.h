// TTTNameFormatter.h
// 
// Copyright (c) 2014 Mattt Thompson (http://mattt.me)
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

#if TARGET_OS_IOS

/**
 Instances of `TTTNameFormatter` create localized string representations of personal names, which may change order or be displayed with or without whitespace delimiting depending on the current locale or source language. 
 
 For example, an individual with the Japanese first name "花子" (Hanako) and last name "山田" (Yamada) should be displayed "山田花子", with last name followed by first name without a space.
 */
@interface TTTNameFormatter : NSFormatter

/**
 Returns a string representation of a personal name given first and last name.
 
 @param firstName The first name, or given name
 @param lastName The last name, family name, or surname
 
 @discussion Each of these parameters may be `nil`
 
 @return The localized personal name
 */
- (NSString *)stringFromFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName;

/**
 Returns a string representation of a personal name given prefix, first name, middle name, last name, and suffix.

 @param prefix The prefix, title, or honorific
 @param firstName The first name, or given name
 @param middleName The middle name or initial
 @param lastName The last name, family name, or surname
 @param suffix The suffix, post-nominal letters, or generational title

 @discussion Each of these parameters may be `nil`

 @return The localized personal name
 */
- (NSString *)stringFromPrefix:(NSString *)prefix
                     firstName:(NSString *)firstName
                    middleName:(NSString *)middleName
                      lastName:(NSString *)lastName
                        suffix:(NSString *)suffix;

@end

#endif
