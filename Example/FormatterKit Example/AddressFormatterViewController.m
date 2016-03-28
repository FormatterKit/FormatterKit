// ArrayFormatterViewController.m
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

#import "AddressFormatterViewController.h"

#import <FormatterKit/TTTAddressFormatter.h>

NS_ENUM(NSUInteger, AddressFormatterViewControllerFormatterViewControllerSectionIndexes) {
    UnitedStatesSectionIndex,
    UnitedKingdomSectionIndex,
    JapanSectionIndex,
};

NS_ENUM(NSUInteger, AddressFormatterViewControllerFormatterViewControllerRowIndexes) {
    ComponentsRowIndex,
    CurrentLocaleFormattedRowIndex,
    NativeLocaleFormattedRowIndex,
};

@interface AddressFormatterViewController ()
@property (readwrite, nonatomic, strong) NSArray *examples;
@end

@implementation AddressFormatterViewController
@synthesize examples = _examples;

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }
    
    self.title = NSLocalizedString(@"Address Formatter", nil);
    
    NSMutableArray *mutableExamples = [NSMutableArray array];
    [mutableExamples addObject:@[@"633 Stag Trail Rd", @"North Caldwell", @"NJ", @"07006", @"United States"]];
    [mutableExamples addObject:@[@"221b Baker St", @"Paddington", @"Greater London", @"NW1 6XE", @"United Kingdom"]];
    [mutableExamples addObject:@[@"渋谷１−１２−２３", @"渋谷区", @"東京都", @"〒１５０−０００２", @"日本"]];
    self.examples = [NSArray arrayWithArray:mutableExamples];

    return self;
}

+ (NSString *)formatterDescription {
    return NSLocalizedString(@"Addresses formats vary greatly across different regions. TTTAddressFormatter ties into the Address Book frameworks to help your users find their place in the world.", nil);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section
{
    return 3;
}

- (NSString *)tableView:(__unused UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case UnitedStatesSectionIndex:            
            return NSLocalizedString(@"United States", nil);
        case UnitedKingdomSectionIndex:
            return NSLocalizedString(@"United Kingdom", nil);
        case JapanSectionIndex:
            return NSLocalizedString(@"Japan", nil);
        default:
            return nil;
    }
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    static TTTAddressFormatter *_addressFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _addressFormatter = [[TTTAddressFormatter alloc] init];
    });
    
    switch (indexPath.row) {
        case ComponentsRowIndex:
            cell.detailTextLabel.font = [UIFont fontWithName:@"Menlo" size:14.0f];
            break;
        case CurrentLocaleFormattedRowIndex:
            _addressFormatter.locale = [NSLocale currentLocale];
            break;
        case NativeLocaleFormattedRowIndex:
            switch (indexPath.section) {
                case UnitedStatesSectionIndex:
                    _addressFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                    break;
                case UnitedKingdomSectionIndex:
                    _addressFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_UK"];
                    break;
                case JapanSectionIndex:
                    _addressFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.numberOfLines = 5;
  
    NSArray *addressComponents = self.examples[(NSUInteger)indexPath.section];
    NSString *street = addressComponents[0];
    NSString *locality = addressComponents[1];
    NSString *region = addressComponents[2];
    NSString *postalCode = addressComponents[3];
    NSString *country = addressComponents[4];
    
    switch (indexPath.row) {
        case ComponentsRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Components", nil);
            cell.detailTextLabel.text = [addressComponents componentsJoinedByString:@", "];
            break;
        case CurrentLocaleFormattedRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Current Locale", nil);
            break;
        case NativeLocaleFormattedRowIndex:
            cell.textLabel.text = NSLocalizedString(@"Native Locale", nil);
            break;
        default:
            break;
    }
    
    if (indexPath.row == CurrentLocaleFormattedRowIndex || indexPath.row == NativeLocaleFormattedRowIndex ) {
        cell.detailTextLabel.text = [_addressFormatter stringFromAddressWithStreet:street locality:locality region:region postalCode:postalCode country:country];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(__unused UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case ComponentsRowIndex:
            return 80.0f;
            break;
        default:
            switch (indexPath.section) {
                case UnitedKingdomSectionIndex:
                    return 150.0f;
                    break;
                default:
                    return 110.0f;
                    break;
            }
            break;
    }
}

@end
