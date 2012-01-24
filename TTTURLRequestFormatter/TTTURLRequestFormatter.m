// TTTURLRequestFormatter.m
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

#import "TTTURLRequestFormatter.h"

@interface NSMutableString (TTTURLRequestFormatter)
- (void)appendCommandLineArgument:(NSString *)arg;
@end

@implementation TTTURLRequestFormatter

- (NSString *)stringFromURLRequest:(NSURLRequest *)request {
    return [NSString stringWithFormat:@"%@ '%@'", [request HTTPMethod], [[request URL] absoluteString]];
}

+ (NSString *)cURLCommandFromURLRequest:(NSURLRequest *)request {
    NSMutableString *command = [NSMutableString stringWithString:@"curl"];
    
    [command appendCommandLineArgument:[NSString stringWithFormat:@"-X %@", [request HTTPMethod]]];

    if ([[request HTTPBody] length] > 0) {
        NSString *HTTPBodyString = [[[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding] autorelease];
        [command appendCommandLineArgument:[NSString stringWithFormat:@"-d %@", HTTPBodyString]];
    }
    
    NSString *acceptEncodingHeader = [[request allHTTPHeaderFields] valueForKey:@"Accept-Encoding"];
    if ([acceptEncodingHeader rangeOfString:@"gzip"].location != NSNotFound) {
        [command appendCommandLineArgument:@"--compressed"];
    }
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[request URL]];
    for (NSHTTPCookie *cookie in cookies) {
        [command appendCommandLineArgument:[NSString stringWithFormat:@"--cookie \"%@=%@\"", [cookie name], [cookie value]]];
    }    
    
    for (id field in [request allHTTPHeaderFields]) {
        [command appendCommandLineArgument:[NSString stringWithFormat:@"-H %@", [NSString stringWithFormat:@"'%@: %@'", field, [[request valueForHTTPHeaderField:field] stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"]]]];
    }
    
    [command appendCommandLineArgument:[NSString stringWithFormat:@"\"%@\"", [[request URL] absoluteString]]];
    
    return [NSString stringWithString:command];
}

+ (NSString *)WgetCommandFromURLRequest:(NSURLRequest *)request {
    if (!([[request HTTPMethod] isEqualToString:@"GET"] || [[request HTTPMethod] isEqualToString:@"POST"])) {
        [NSException raise:@"Invalid HTTP Method" format:@"Wget can only make GET and POST requests", request];
    }
    
    NSMutableString *command = [NSMutableString stringWithString:@"curl"];
    
    if ([[request HTTPBody] length] > 0) {
        NSString *HTTPBodyString = [[[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding] autorelease];
        [command appendCommandLineArgument:[NSString stringWithFormat:@"-d %@", HTTPBodyString]];
    }
    
    for (id field in [request allHTTPHeaderFields]) {
        [command appendCommandLineArgument:[NSString stringWithFormat:@"--header=%@", [NSString stringWithFormat:@"'%@: %@'", field, [[request valueForHTTPHeaderField:field] stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"]]]];
    }
    
    [command appendCommandLineArgument:[NSString stringWithFormat:@"\"%@\"", [[request URL] absoluteString]]];
    
    return [NSString stringWithString:command];
}

@end

#pragma mark -

@implementation TTTHTTPURLResponseFormatter

- (NSString *)stringFromHTTPURLResponse:(NSHTTPURLResponse *)response {
    return [NSString stringWithFormat:@"%d '%@'", [response statusCode], [[response URL] absoluteString]];
}

@end

#pragma mark -

@implementation NSMutableString (TTTURLRequestFormatter)

- (void)appendCommandLineArgument:(NSString *)arg {
    [self appendFormat:@" %@", [arg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
}

@end
