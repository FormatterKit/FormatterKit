// HoursOfOperationFormatterViewController.m
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

#import "HoursOfOperationFormatterViewController.h"

#import "TTTHoursOfOperation.h"

enum {
    StandardSectionIndex,
    WeekdaysAndWeekendsSectionIndex,
    EverydaySectionIndex,
    SingleDaySectionIndex,
} HoursOfOperationFormatterViewControllerSectionIndexes;

@interface HoursOfOperationFormatterViewController ()
@property (readwrite, nonatomic, retain) NSArray *examples;
@end

@implementation HoursOfOperationFormatterViewController
@synthesize examples = _examples;

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }
    
    self.title = NSLocalizedString(@"Hours of Operation Formatter", nil);
    
    NSMutableArray *mutableExamples = [NSMutableArray array];
    
    TTTWeeklyHoursOfOperation *hoursOfOperation = [[[TTTWeeklyHoursOfOperation alloc] init] autorelease];
    [hoursOfOperation setHoursWithString:@"08:00-19:00" forWeekday:TTTMonday];
    [hoursOfOperation setHoursWithString:@"08:00-19:00" forWeekday:TTTTuesday];
    [hoursOfOperation setHoursWithString:@"08:00-19:00" forWeekday:TTTWednesday];
    [hoursOfOperation setHoursWithString:@"09:00-12:00" forWeekday:TTTThursday];
    [hoursOfOperation setHoursWithString:@"closed" forWeekday:TTTFriday];
    [hoursOfOperation setHoursWithString:@"11:00-25:00" forWeekday:TTTSaturday];
    [hoursOfOperation setHoursWithString:@"11:00-25:00" forWeekday:TTTSunday];
    [mutableExamples addObject:hoursOfOperation];
    
    TTTWeeklyHoursOfOperation *weekdaysAndWeekendsHoursOfOperation = [[[TTTWeeklyHoursOfOperation alloc] init] autorelease];
    [weekdaysAndWeekendsHoursOfOperation setHoursWithString:@"09:00-19:00" forWeekday:TTTMonday];
    [weekdaysAndWeekendsHoursOfOperation setHoursWithString:@"09:00-19:00" forWeekday:TTTTuesday];
    [weekdaysAndWeekendsHoursOfOperation setHoursWithString:@"09:00-19:00" forWeekday:TTTWednesday];
    [weekdaysAndWeekendsHoursOfOperation setHoursWithString:@"09:00-19:00" forWeekday:TTTThursday];
    [weekdaysAndWeekendsHoursOfOperation setHoursWithString:@"09:00-19:00" forWeekday:TTTFriday];
    [weekdaysAndWeekendsHoursOfOperation setHoursWithString:@"10:00-14:00" forWeekday:TTTSaturday];
    [weekdaysAndWeekendsHoursOfOperation setHoursWithString:@"10:00-14:00" forWeekday:TTTSunday];
    [mutableExamples addObject:weekdaysAndWeekendsHoursOfOperation];
    
    TTTWeeklyHoursOfOperation *everydayHoursOfOperation = [[[TTTWeeklyHoursOfOperation alloc] init] autorelease];
    [everydayHoursOfOperation setHoursWithString:@"11:00-20:00" forWeekday:TTTMonday];
    [everydayHoursOfOperation setHoursWithString:@"11:00-20:00" forWeekday:TTTTuesday];
    [everydayHoursOfOperation setHoursWithString:@"11:00-20:00" forWeekday:TTTWednesday];
    [everydayHoursOfOperation setHoursWithString:@"11:00-20:00" forWeekday:TTTThursday];
    [everydayHoursOfOperation setHoursWithString:@"11:00-20:00" forWeekday:TTTFriday];
    [everydayHoursOfOperation setHoursWithString:@"11:00-20:00" forWeekday:TTTSaturday];
    [everydayHoursOfOperation setHoursWithString:@"11:00-20:00" forWeekday:TTTSunday];
    [mutableExamples addObject:everydayHoursOfOperation];
    
    TTTWeeklyHoursOfOperation *singleDayHoursOfOperation = [[[TTTWeeklyHoursOfOperation alloc] init] autorelease];
    [singleDayHoursOfOperation setHoursWithString:@"11:00-15:00" forWeekday:TTTMonday];
    [mutableExamples addObject:singleDayHoursOfOperation];
    
    self.examples = [NSArray arrayWithArray:mutableExamples];
    
    return self;
}

+ (NSString *)formatterDescription {
    return NSLocalizedString(@"Modeling and displaying hours of operation is tricky business. It's perhaps one of the most prolific ratholes that has ever existed--a trap that has ensnared many a venturing programmer with its tendrils of perceived simplicity and maddening edge-cases. Let TTTHoursOfOperation save you hours.", nil);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (NSInteger)[self.examples count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case WeekdaysAndWeekendsSectionIndex:
            return NSLocalizedString(@"Weekday and Weekend Grouping", nil);
        case EverydaySectionIndex:
            return NSLocalizedString(@"Everyday Grouping", nil);
        case SingleDaySectionIndex:
            return NSLocalizedString(@"Single Day", nil);
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTTWeeklyHoursOfOperation *hoursOfOperation = [self.examples objectAtIndex:indexPath.section];
    CGSize size = [[hoursOfOperation description] sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(280.0f, tableView.frame.size.height) lineBreakMode:UILineBreakModeWordWrap];

    return fmaxf(size.height + 16.0f, self.tableView.rowHeight);
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.numberOfLines = 0;
    
    TTTWeeklyHoursOfOperation *hoursOfOperation = [self.examples objectAtIndex:indexPath.section];
    cell.textLabel.text = [hoursOfOperation description];
}

@end
