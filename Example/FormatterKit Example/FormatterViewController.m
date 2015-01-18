// FormatterViewController.m
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

#import "FormatterViewController.h"

@implementation FormatterViewController

+ (NSString *)formatterDescription {
    return nil;
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wconversion"
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    descriptionLabel.font = [UIFont systemFontOfSize:13];
    descriptionLabel.text = [[self class] formatterDescription];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.textColor = [UIColor colorWithRed:0.298f green:0.337f blue:0.424f alpha:1.000f];
    descriptionLabel.shadowColor = [UIColor whiteColor];
    descriptionLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);

    CGSize descriptionSize = [descriptionLabel.text sizeWithFont:descriptionLabel.font constrainedToSize:CGRectInset(self.tableView.frame, 20.0f, 0.0f).size lineBreakMode:UILineBreakModeWordWrap];
    descriptionLabel.frame = CGRectMake(20.0f, 10.0f, descriptionSize.width, descriptionSize.height);
#pragma clang diagnostic pop

    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectInset(descriptionLabel.frame, -20.0f, -10.0f)];
    [tableHeaderView addSubview:descriptionLabel];

    self.tableView.tableHeaderView = tableHeaderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.rowHeight = 50.0f;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(__unused NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    if ([self respondsToSelector:@selector(configureCell:forRowAtIndexPath:)]) {
        [self configureCell:cell forRowAtIndexPath:indexPath];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
