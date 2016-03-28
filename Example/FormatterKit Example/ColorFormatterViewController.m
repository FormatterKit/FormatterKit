// ColorFormatterViewController.m
// 
// Copyright (c) 2013 Mattt Thompson (http://mattt.me)
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

#import "ColorFormatterViewController.h"

#import <FormatterKit/TTTColorFormatter.h>

static UIImage * UIImageForSwatchOfColorWithSize(UIColor *color, CGSize size) {
    UIImage *image = nil;

    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);

    UIGraphicsBeginImageContext(rect.size);
    {
        CGContextRef c = UIGraphicsGetCurrentContext();

        CGContextSetFillColorWithColor(c, [color CGColor]);
        CGContextFillRect(c, rect);

        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    return image;
}

NS_ENUM(NSUInteger, ColorFormatterViewControllerSectionIndexes) {
    HexadecimalSectionIndex,
    RGBSectionIndex,
    CMYKSectionIndex,
    HSLSectionIndex,
    UIColorSectionIndex,
};

@interface ColorFormatterViewController ()
@property (readwrite, nonatomic, strong) NSArray *examples;
@end

@implementation ColorFormatterViewController
@synthesize examples = _examples;

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }

    self.title = NSLocalizedString(@"Color Formatter", nil);

    NSMutableArray *mutableExamples = [NSMutableArray array];
    [mutableExamples addObject:[UIColor redColor]];
    [mutableExamples addObject:[UIColor orangeColor]];
    [mutableExamples addObject:[UIColor yellowColor]];
    [mutableExamples addObject:[UIColor greenColor]];
    [mutableExamples addObject:[UIColor cyanColor]];
    [mutableExamples addObject:[UIColor blueColor]];
    [mutableExamples addObject:[UIColor purpleColor]];
    self.examples = [NSArray arrayWithArray:mutableExamples];

    return self;
}

+ (NSString *)formatterDescription {
    return NSLocalizedString(@"RGB, CMYK, and HSL your ROY G. BIV in style. TTTColorFormatter provides string representations of colors.", nil);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section
{
    return (NSInteger)[self.examples count];
}

- (NSString *)tableView:(__unused UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case HexadecimalSectionIndex:
            return NSLocalizedString(@"Hexadecimal", nil);
        case RGBSectionIndex:
            return NSLocalizedString(@"RGB", nil);
        case CMYKSectionIndex:
            return NSLocalizedString(@"CMYK", nil);
        case HSLSectionIndex:
            return NSLocalizedString(@"HSL", nil);
        case UIColorSectionIndex:
            return NSLocalizedString(@"UIColor", nil);
        default:
            return nil;
    }
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    static TTTColorFormatter *_colorFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _colorFormatter = [[TTTColorFormatter alloc] init];
    });

    UIColor *color = self.examples[(NSUInteger)indexPath.row];

    cell.imageView.image = UIImageForSwatchOfColorWithSize(color, CGSizeMake(30.0f, 30.0f));

    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 1;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;

    switch (indexPath.section) {
        case HexadecimalSectionIndex:
            cell.textLabel.text = [_colorFormatter hexadecimalStringFromColor:color];
            break;
        case RGBSectionIndex:
            cell.textLabel.text = [_colorFormatter RGBStringFromColor:color];
            break;
        case CMYKSectionIndex:
            cell.textLabel.text = [_colorFormatter CMYKStringFromColor:color];
            break;
        case HSLSectionIndex:
            cell.textLabel.text = [_colorFormatter HSLStringFromColor:color];
            break;
        case UIColorSectionIndex:
            cell.textLabel.text = [_colorFormatter UIColorDeclarationFromColor:color];
        default:
            break;
    }
}

@end
