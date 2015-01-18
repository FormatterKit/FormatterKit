// TTTURLRequestFormatter.h
//
// Copyright (c) 2011–2015 Mattt Thompson (http://mattt.me)
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
 Instances of `TTTURLRequestFormatter` create localized string representations of `NSURLRequest` objects. There are also class methods that generate equivalent `curl` and `wget` command strings.

 For example, a particular request may be formatted as "GET http://example.com/"
 */
@interface TTTURLRequestFormatter : NSFormatter

///-------------------------
/// @name Converting Objects
///-------------------------

/**
 Returns a string representation of a given request.

 @param request The request to format.
 */
- (NSString *)stringFromURLRequest:(NSURLRequest *)request;

/**
 Returns a `curl` command string equivalent of the specified request object.

 @param request The request to format.
 */
+ (NSString *)cURLCommandFromURLRequest:(NSURLRequest *)request;

/**
 Returns a `wget` command string equivalent of the specified request object.

 @param request The request to format.
 */
+ (NSString *)WgetCommandFromURLRequest:(NSURLRequest *)request;

@end

#pragma mark -

/**
 Instances of `TTTHTTPURLResponseFormatter` create localized string representations of `NSHTTPURLResponse` objects.

 For example, a particular response may be formatted as "200 http://example.com/"
 */
@interface TTTHTTPURLResponseFormatter : NSFormatter

///-------------------------
/// @name Converting Objects
///-------------------------

/**
 Returns a string representation of a given HTTP response.

 @param response The HTTP response to format.
 */
- (NSString *)stringFromHTTPURLResponse:(NSHTTPURLResponse *)response;

@end
