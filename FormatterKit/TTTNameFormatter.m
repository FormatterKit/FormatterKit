// TTTNameFormatter.m
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

#import "TTTNameFormatter.h"

#if !defined(__MAC_OS_X_VERSION_MAX_ALLOWED)

#import <AddressBook/AddressBook.h>

@implementation TTTNameFormatter

- (NSString *)stringFromFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
{
    return [self stringFromPrefix:nil firstName:firstName middleName:nil lastName:lastName suffix:nil];
}

- (NSString *)stringFromPrefix:(NSString *)prefix
                     firstName:(NSString *)firstName
                    middleName:(NSString *)middleName
                      lastName:(NSString *)lastName
                        suffix:(NSString *)suffix
{
    ABRecordRef record = ABPersonCreate();
    ABRecordSetValue(record, kABPersonPrefixProperty, (__bridge CFStringRef)prefix, NULL);
    ABRecordSetValue(record, kABPersonFirstNameProperty, (__bridge CFStringRef)firstName, NULL);
    ABRecordSetValue(record, kABPersonMiddleNameProperty, (__bridge CFStringRef)middleName, NULL);
    ABRecordSetValue(record, kABPersonLastNameProperty, (__bridge CFStringRef)lastName, NULL);
    ABRecordSetValue(record, kABPersonSuffixProperty, (__bridge CFStringRef)suffix, NULL);

    NSString *name = (__bridge_transfer NSString *)ABRecordCopyCompositeName(record);
    CFRelease(record);

    return name;
}

@end

#endif
