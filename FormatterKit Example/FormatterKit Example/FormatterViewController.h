//
//  FormatterViewController.h
//  FormatterKit Example
//
//  Created by Mattt Thompson on 11/09/19.
//  Copyright 2011年 Gowalla. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FormatterViewController <NSObject>
+ (NSString *)formatterDescription;
@end

@interface FormatterViewController : UITableViewController <FormatterViewController>

@end
