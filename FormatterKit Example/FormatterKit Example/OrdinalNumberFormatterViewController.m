// OrdinalNumberFormatterViewController.m
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

#import "OrdinalNumberFormatterViewController.h"

#import "TTTOrdinalNumberFormatter.h"

@interface OrdinalNumberFormatterViewController ()
@property (readwrite, nonatomic) NSArray *locales;
@property (readwrite, nonatomic) NSArray *numbers;
@end

@implementation OrdinalNumberFormatterViewController
@synthesize locales = _locales;
@synthesize numbers = _numbers;

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }
    
    self.title = NSLocalizedString(@"Ordinal Number Formatter", nil);
    
    NSMutableArray *mutableLocales = [NSMutableArray array];
    [mutableLocales addObject:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [mutableLocales addObject:[[NSLocale alloc] initWithLocaleIdentifier:@"es_ES"]];
    [mutableLocales addObject:[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"]];
    [mutableLocales addObject:[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"]];
    [mutableLocales addObject:[[NSLocale alloc] initWithLocaleIdentifier:@"ga_IE"]];
    [mutableLocales addObject:[[NSLocale alloc] initWithLocaleIdentifier:@"it_IT"]];
    [mutableLocales addObject:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [mutableLocales addObject:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    [mutableLocales addObject:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_PT"]];
    [mutableLocales addObject:[[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hant_CN"]];
    self.locales = [NSArray arrayWithArray:mutableLocales];
    
    NSMutableArray *mutableNumbers = [NSMutableArray array];
    [mutableNumbers addObject:[NSNumber numberWithInteger:1]];
    [mutableNumbers addObject:[NSNumber numberWithInteger:2]];
    [mutableNumbers addObject:[NSNumber numberWithInteger:3]];
    [mutableNumbers addObject:[NSNumber numberWithInteger:4]];
    self.numbers = [NSArray arrayWithArray:mutableNumbers];
    
    return self;
}


+ (NSString *)formatterDescription {
    return NSLocalizedString(@"TTTOrdinalNumberFormatter formats cardinals (1, 2, 3, etc.) into ordinals (1st, 2nd, 3rd, etc.), and supports English, Spanish, French, German, Irish, Italian, Japanese, Dutch, Portuguese, and Mandarin Chinese. For other languages, you can use the standard default, or override it with your own. For languages whose ordinal indicator depends upon the grammatical properties of the predicate, TTTOrdinalNumberFormatter can format according to a specified gender and/or plurality.", nil);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.locales count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.numbers count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSLocale *locale = [self.locales objectAtIndex:section];
    return [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:[locale localeIdentifier]];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    static TTTOrdinalNumberFormatter *_ordinalNumberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ordinalNumberFormatter = [[TTTOrdinalNumberFormatter alloc] init];
    });
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    NSLocale *locale = [self.locales objectAtIndex:indexPath.section];
    NSNumber *number = [self.numbers objectAtIndex:indexPath.row];
    
    [_ordinalNumberFormatter setLocale:locale];
    cell.textLabel.text = [_ordinalNumberFormatter stringFromNumber:number];
}

@end
