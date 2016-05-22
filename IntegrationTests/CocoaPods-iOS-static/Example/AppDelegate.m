//
//  AppDelegate.m
//  Example
//
//  Created by Victor Ilyukevich on 5/21/16.
//  Copyright © 2016 Open Source. All rights reserved.
//

#import "AppDelegate.h"
#import <FormatterKit/TTTTimeIntervalFormatter.h>

@implementation AppDelegate

- (NSString *)foo
{
  TTTTimeIntervalFormatter *formatter = [TTTTimeIntervalFormatter new];
  return [formatter stringForTimeInterval:-3600];
}

@end
