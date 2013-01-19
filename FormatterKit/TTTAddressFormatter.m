// TTTAddressFormatter.m
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

#import "TTTAddressFormatter.h"

#if defined(__ABPerson__)

@implementation TTTAddressFormatter
@synthesize locale = _locale;

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.locale = [NSLocale currentLocale];
    
    return self;
}

- (NSString *)stringFromAddressWithStreet:(NSString *)street
                                 locality:(NSString *)locality
                                   region:(NSString *)region
                               postalCode:(NSString *)postalCode
                                  country:(NSString *)country
{
    NSMutableDictionary *mutableAddressComponents = [NSMutableDictionary dictionary];
    
    if (street) {
        [mutableAddressComponents setValue:street forKey:(__bridge NSString *)kABPersonAddressStreetKey];
    }
    
    if (locality) {
        [mutableAddressComponents setValue:locality forKey:(__bridge NSString *)kABPersonAddressCityKey];
    }
    
    if (region) {
        [mutableAddressComponents setValue:region forKey:(__bridge NSString *)kABPersonAddressStateKey];
    }
    
    if (postalCode) {
        [mutableAddressComponents setValue:postalCode forKey:(__bridge NSString *)kABPersonAddressZIPKey];
    }
    
    if (country) {
        [mutableAddressComponents setValue:country forKey:(__bridge NSString *)kABPersonAddressCountryKey];
    }
    
    [mutableAddressComponents setValue:[self.locale objectForKey:NSLocaleCountryCode] forKey:(__bridge NSString *)kABPersonAddressCountryCodeKey];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED
    return ABCreateStringWithAddressDictionary(mutableAddressComponents, !!country);
#elif __MAC_OS_X_VERSION_MIN_REQUIRED
    return [[[ABAddressBook sharedAddressBook] formattedAddressFromDictionary:mutableAddressComponents] string];
#else
    return nil;
#endif
}

#pragma mark NSFormatter

- (NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    return ABCreateStringWithAddressDictionary(anObject, YES);
}

- (BOOL)getObjectValue:(id *)obj
             forString:(NSString *)string
      errorDescription:(NSString **)error
{
    *error = NSLocalizedStringFromTable(@"Method Not Implemented", @"FormatterKit", nil);
    
    return NO;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    self.locale = [aDecoder decodeObjectForKey:@"locale"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.locale forKey:@"locale"];
}

@end

#endif
