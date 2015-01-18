// RootViewController.m
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

#import "RootViewController.h"
#import "AddressFormatterViewController.h"
#import "ArrayFormatterViewController.h"
#import "ColorFormatterViewController.h"
#import "LocationFormatterViewController.h"
#import "NameFormatterViewController.h"
#import "OrdinalNumberFormatterViewController.h"
#import "TimeIntervalFormatterViewController.h"
#import "UnitOfInformationFormatterViewController.h"
#import "URLRequestFormatterViewController.h"

NS_ENUM(NSUInteger, RootViewControllerRowIndexes) {
    AddressRowIndex,
    ArrayRowIndex,
    ColorRowIndex,
    LocationRowIndex,
    NameRowIndex,
    OrdinalNumberRowIndex,
    TimeIntervalRowIndex,
    UnitOfInformationRowIndex,
    URLRequestRowIndex
};

@implementation RootViewController

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }

    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"FormatterKit", nil);

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", nil) style:UIBarButtonItemStyleDone target:nil action:nil];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    switch (indexPath.row) {
        case AddressRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Address Formatter", nil);
            break;
        case ArrayRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Array Formatter", nil);
            break;
        case ColorRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Color Formatter", nil);
            break;
        case LocationRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Location Formatter", nil);
            break;
        case NameRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Name Formatter", nil);
            break;
        case OrdinalNumberRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Ordinal Number Formatter", nil);
            break;
        case TimeIntervalRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Time Interval Formatter", nil);
            break;
        case UnitOfInformationRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Unit of Information Formatter", nil);
            break;
        case URLRequestRowIndex:
            cell.textLabel.text = NSLocalizedString(@"URL Request Formatter", nil);
            break;
        default:
            break;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(__unused UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = nil;
    switch (indexPath.row) {
        case AddressRowIndex:
            viewController = [[AddressFormatterViewController alloc] init];
            break;
        case ArrayRowIndex:
            viewController = [[ArrayFormatterViewController alloc] init];
            break;
        case ColorRowIndex:
            viewController = [[ColorFormatterViewController alloc] init];
            break;
        case LocationRowIndex:
            viewController = [[LocationFormatterViewController alloc] init];
            break;
        case NameRowIndex:
            viewController = [[NameFormatterViewController alloc] init];
            break;
        case OrdinalNumberRowIndex:
            viewController = [[OrdinalNumberFormatterViewController alloc] init];
            break;
        case TimeIntervalRowIndex:
            viewController = [[TimeIntervalFormatterViewController alloc] init];
            break;
        case UnitOfInformationRowIndex:
            viewController = [[UnitOfInformationFormatterViewController alloc] init];
            break;
        case URLRequestRowIndex:
            viewController = [[URLRequestFormatterViewController alloc] init];
            break;
    }

    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
