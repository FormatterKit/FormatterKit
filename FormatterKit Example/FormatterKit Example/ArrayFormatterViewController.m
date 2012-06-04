// ArrayFormatterViewController.m
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

#import "ArrayFormatterViewController.h"

#import "TTTArrayFormatter.h"

enum {
    StandardSectionIndex,
    AbbreviatedConjunctionSectionIndex,
    NoSerialDelimeterSectionIndex,
    DataStyleSectionIndex,
} ArrayFormatterViewControllerSectionIndexes;

@interface ArrayFormatterViewController ()
@property (readwrite, nonatomic) NSArray *examples;
@end

@implementation ArrayFormatterViewController
@synthesize examples = _examples;

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }
    
    self.title = NSLocalizedString(@"Array Formatter", nil);
    
    NSMutableArray *mutableExamples = [NSMutableArray array];
    [mutableExamples addObject:[NSArray arrayWithObjects:@"John Lennon", @"Paul McCartney", @"George Harrison", @"Ringo Starr", nil]];
    [mutableExamples addObject:[NSArray arrayWithObjects:@"Bertrand Russel", @"Baruch de Spinoza", @"John Rawls", nil]];
    [mutableExamples addObject:[NSArray arrayWithObjects:@"Friedrich Hayek", @"John Maynard Keynes", nil]];
    [mutableExamples addObject:[NSArray arrayWithObjects:@"Kurt Vonnegut", nil]];
    self.examples = [NSArray arrayWithArray:mutableExamples];

    return self;
}

+ (NSString *)formatterDescription {
    return NSLocalizedString(@"Think of this as a production-ready alternative to NSArray -componentsJoinedByString:. TTTArrayFormatter comes with internationalization baked-in, and provides a concise API that allows you to configure for any edge cases.", nil);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.examples count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case AbbreviatedConjunctionSectionIndex:
            return NSLocalizedString(@"Abbreviated Conjunction", nil);
        case NoSerialDelimeterSectionIndex:
            return NSLocalizedString(@"No Serial Delimiter (Oxford Comma)", nil);
        case DataStyleSectionIndex:
            return NSLocalizedString(@"Data Style", nil);
        default:
            return nil;
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    static TTTArrayFormatter *_arrayFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _arrayFormatter = [[TTTArrayFormatter alloc] init];
    });
    
    [_arrayFormatter setArrayStyle:TTTArrayFormatterSentenceStyle];
    [_arrayFormatter setUsesSerialDelimiter:YES];
    [_arrayFormatter setUsesAbbreviatedConjunction:NO];
    
    switch (indexPath.section) {
        case StandardSectionIndex:
            break;
        case AbbreviatedConjunctionSectionIndex:
            [_arrayFormatter setUsesAbbreviatedConjunction:YES];
            break;
        case NoSerialDelimeterSectionIndex:
            [_arrayFormatter setUsesSerialDelimiter:NO];
            break;
        case DataStyleSectionIndex:
            [_arrayFormatter setArrayStyle:TTTArrayFormatterDataStyle];
            break;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 3;
    
    NSArray *example = [self.examples objectAtIndex:indexPath.row];
    cell.textLabel.text = [_arrayFormatter stringFromArray:example];
}

@end
