//
//  FormatterViewController.m
//  FormatterKit Example
//
//  Created by Mattt Thompson on 11/09/19.
//  Copyright 2011年 Gowalla. All rights reserved.
//

#import "FormatterViewController.h"

@interface FormatterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation FormatterViewController

+ (NSString *)formatterDescription {
    return nil;
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
    UILabel *descriptionLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    descriptionLabel.font = [UIFont systemFontOfSize:14];
    descriptionLabel.text = [[self class] formatterDescription];
    
    CGSize descriptionSize = [descriptionLabel.text sizeWithFont:descriptionLabel.font constrainedToSize:CGRectInset(self.tableView.frame, 10.0f, 0.0f).size lineBreakMode:UILineBreakModeWordWrap];    
    descriptionLabel.frame = CGRectMake(10.0f, 10.0f, descriptionSize.width, descriptionSize.height);
    
    UIView *tableHeaderView = [[[UIView alloc] initWithFrame:CGRectInset(descriptionLabel.frame, -10.0f, -10.0f)] autorelease];
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
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
