// TimeIntervalFormatterViewController.m
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

#import "TimeIntervalFormatterViewController.h"

#import "TTTTimeIntervalFormatter.h"

NS_ENUM(NSUInteger, TimeIntervalFormatterViewControllerSectionIndexes) {
    StandardPastSectionIndex,
    StandardFutureSectionIndex,
    IdiomaticDeicticExpressionsSectionIndex,
};

NS_ENUM(NSUInteger, TimeIntervalFormatterViewControllerRowIndexes) {
    SecondsRowIndex,
    MinutesRowIndex,
    HoursRowIndex,
    DaysRowIndex,
    TwoDaysRowIndex,
    MonthRowIndex,
};

@implementation TimeIntervalFormatterViewController

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }

    self.title = NSLocalizedString(@"Time Interval Formatter", nil);

    return self;
}

+ (NSString *)formatterDescription {
    return NSLocalizedString(@"TTTTimeIntervalFormatter formats distance in time into a smart relative display, with options to extend that behavior to your particular use case.", nil);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section
{
    return 6;
}

- (NSString *)tableView:(__unused UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case StandardPastSectionIndex:
            return NSLocalizedString(@"Standard Past", nil);
        case StandardFutureSectionIndex:
            return NSLocalizedString(@"Standard Future", nil);
        case IdiomaticDeicticExpressionsSectionIndex:
            return NSLocalizedString(@"Idiomatic Past", nil);
        default:
            return nil;
    }
}

- (void)configureCell:(__unused UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    static TTTTimeIntervalFormatter *_timeIntervalFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
        [_timeIntervalFormatter setLocale:[NSLocale currentLocale]];
    });

    switch (indexPath.section) {
        case StandardPastSectionIndex:
        case StandardFutureSectionIndex:
            [_timeIntervalFormatter setUsesIdiomaticDeicticExpressions:NO];
            break;
        case IdiomaticDeicticExpressionsSectionIndex:
            [_timeIntervalFormatter setUsesIdiomaticDeicticExpressions:YES];
            break;
    }

    NSTimeInterval timeInterval = 0;
    switch (indexPath.row) {
        case SecondsRowIndex:
            timeInterval = 1;
            break;
        case MinutesRowIndex:
            timeInterval = 100;
            break;
        case HoursRowIndex:
            timeInterval = 10000;
            break;
        case DaysRowIndex:
            timeInterval = 100000;
            break;
        case TwoDaysRowIndex:
            timeInterval = 200000;
            break;
        case MonthRowIndex:
            timeInterval = 10000000;
            break;
    }

    if (indexPath.section != StandardFutureSectionIndex) {
        timeInterval = -timeInterval;
    }

    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = [_timeIntervalFormatter stringForTimeInterval:timeInterval];
}

@end
