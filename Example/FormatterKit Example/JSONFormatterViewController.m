//
//  JSONFormatterViewController.m
//
//
//  Created by griffin-stewie on 2014/03/18.
//
//

#import "JSONFormatterViewController.h"
#import "TTTJSONFormatter.h"

@interface JSONFormatterViewController ()
@property (nonatomic, strong) id JSON;
@end

@implementation JSONFormatterViewController

@synthesize JSON = _JSON;

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }
    
    self.title = NSLocalizedString(@"JSON Formatter", nil);
    self.JSON = @{@"foo": @"bar"};

    return self;
}

+ (NSString *)formatterDescription {
    return NSLocalizedString(@"TTTJSONFormatter generates jq commands from JSON for debugging in the console.", nil);
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(__unused UITableView *)tableView
titleForHeaderInSection:(__unused NSInteger)section
{
    return NSLocalizedString(@"jq Command", nil);
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(__unused NSIndexPath *)indexPath
{
    NSString *command = [TTTJSONFormatter jqCommandFromJSON:self.JSON];
    CGSize constrainedSize = CGSizeMake(280.f, tableView.frame.size.height);
    UIFont *constrintFont = [UIFont systemFontOfSize:14.f];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wconversion"
    CGSize size = [command sizeWithFont:constrintFont constrainedToSize:constrainedSize lineBreakMode:UILineBreakModeWordWrap];
#pragma clang diagnostic pop
    
    return fmax(size.height + 16.0f, self.tableView.rowHeight);
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(__unused NSIndexPath *)indexPath {
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [TTTJSONFormatter jqCommandFromJSON:self.JSON];
}
@end
