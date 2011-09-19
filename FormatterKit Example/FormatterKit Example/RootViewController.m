//
//  RootViewController.m
//  FormatterKit Example
//
//  Created by Mattt Thompson on 11/09/19.
//  Copyright 2011年 Gowalla. All rights reserved.
//

#import "RootViewController.h"
#import "ArrayFormatterViewController.h"

enum {
    ArrayRowIndex,
    HoursOfOperationRowIndex,
    LocationRowIndex,
    OrdinalNumberRowIndex,
    TimeIntervalRowIndex,
    URLRequestRowIndex
} RootViewControllerRowIndexes;

@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

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
    
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", nil) style:UIBarButtonItemStyleDone target:nil action:nil] autorelease];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case ArrayRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Array Formatter", nil);
            break;
        case HoursOfOperationRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Hours of Operation Formatter", nil);
            break;
        case LocationRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Location Formatter", nil);
            break;
        case OrdinalNumberRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Ordinal Number Formatter", nil);
            break;
        case TimeIntervalRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Time Interval Formatter", nil);
            break;
        case URLRequestRowIndex:
            cell.textLabel.text = NSLocalizedString(@"URL Request Formatter", nil);
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = nil;
    
    switch (indexPath.section) {
        case ArrayRowIndex:
            viewController = [[[ArrayFormatterViewController alloc] init] autorelease];
            break;
    }
    
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
