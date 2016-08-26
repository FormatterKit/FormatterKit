// TTTAddressFormatter.h
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

#if !TARGET_OS_WATCH && !TARGET_OS_TV

/**
 Instances of `TTTAddressFormatter` create address strings formatted according to a given locale.
 
 For example, addresses in the United States take the form:
    
    Street Address
    City State ZIP
    Country
 
 Whereas addresses in Japan follow a different convention:
 
    Postal Code
    Prefecture Municipality
    Street Address
    Country

 All of the business logic for these rules is handled by`ABCreateStringWithAddressDictionary`, from the `AddressBookUI` framework. `TTTAddressFormatter` acts as a convenient wrapper to this functionality.
 */
@interface TTTAddressFormatter : NSFormatter

/**
 Specifies the locale used to format strings. Defaults to the current system locale.
 */
@property (nonatomic, strong) NSLocale *locale;

///-------------------------
/// @name Converting Objects
///-------------------------

/**
 Returns an address string for the specified components formatted with the receiver's locale.
 
 @param street The street address
 @param locality The locality (a.k.a. city, municipality, township)
 @param region The region (a.k.a. state, prefecture, principality)
 @param postalCode The postal code (a.k.a ZIP code)
 @param country The country
 */
- (NSString *)stringFromAddressWithStreet:(NSString *)street
                                 locality:(NSString *)locality
                                   region:(NSString *)region
                               postalCode:(NSString *)postalCode
                                  country:(NSString *)country;

@end

#endif
