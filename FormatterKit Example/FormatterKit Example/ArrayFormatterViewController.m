//
//  ArrayFormatterViewController.m
//  FormatterKit Example
//
//  Created by Mattt Thompson on 11/09/19.
//  Copyright 2011年 Gowalla. All rights reserved.
//

#import "ArrayFormatterViewController.h"

#import "TTTArrayFormatter.h"

@interface ArrayFormatterViewController ()
@property (readwrite, nonatomic, retain) NSArray *examples;
@end

enum {
    StandardSectionIndex,
    AbbreviatedConjunctionSectionIndex,
    NoSerialDelimeterSectionIndex,
    DataStyleSectionIndex,
} ArrayFormatterViewControllerSectionIndexes;

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
    return NSLocalizedString(@"Think of this as a production-ready alternative to `NSArray -componentsJoinedByString:`. `TTTArrayFormatter` comes with internationalization baked-in, and provides a concise API that allows you to configure for any edge cases.", nil);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.examples count];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    static TTTArrayFormatter *_arrayFormatter = nil;
    if (!_arrayFormatter) {
        _arrayFormatter = [[TTTArrayFormatter alloc] init];
    }
    
    
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
