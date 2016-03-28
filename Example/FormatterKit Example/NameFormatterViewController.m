// NameFormatterViewController.m
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

#import <CoreLocation/CoreLocation.h>
#import "NameFormatterViewController.h"

#import <FormatterKit/TTTNameFormatter.h>

NS_ENUM(NSUInteger, LocationFormatterViewControllerRowIndexes) {
    FirstLastNameRowIndex,
    FirstMiddleLastNameRowIndex,
    PrefixFirstLastNameRowIndex,
    FirstMiddleLastSuffixNameRowIndex,
    JapaneseNameRowIndex,
    OneWordNameRowIndex,
};

@implementation NameFormatterViewController

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }

    self.title = NSLocalizedString(@"Name Formatter", nil);

    return self;
}

+ (NSString *)formatterDescription {
    return NSLocalizedString(@"TTTNameFormatter formats names according to the internationalization standards of the AddressBook framework, which determine, for example, the display order of names and whether or not to delimit components with whitespace.", nil);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section
{
    return 6;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    static TTTNameFormatter *_nameFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nameFormatter = [[TTTNameFormatter alloc] init];
    });

    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;

    switch (indexPath.row) {
        case FirstLastNameRowIndex:
            cell.textLabel.text = [_nameFormatter stringFromFirstName:@"Pierre" lastName:@"de Fermat"];
            break;
        case FirstMiddleLastNameRowIndex:
            cell.textLabel.text = [_nameFormatter stringFromPrefix:nil firstName:@"Gottfried" middleName:@"Wilhelm" lastName:@"von Leibniz" suffix:nil];
            break;
        case PrefixFirstLastNameRowIndex:
            cell.textLabel.text = [_nameFormatter stringFromPrefix:@"Sir" firstName:@"Isaac" middleName:nil lastName:@"Newton" suffix:nil];
            break;
        case FirstMiddleLastSuffixNameRowIndex:
            cell.textLabel.text = [_nameFormatter stringFromPrefix:nil firstName:@"Guillaume" middleName:@"François" lastName:@"Antoine" suffix:@"Marquis de l'Hôpital"];
            break;
        case JapaneseNameRowIndex:
            cell.textLabel.text = [_nameFormatter stringFromFirstName:@"孝和" lastName:@"関"];
            break;
        case OneWordNameRowIndex:
            cell.textLabel.text = [_nameFormatter stringFromFirstName:@"Aristotle" lastName:nil];
            break;
        default:
            break;
    }
}

@end
