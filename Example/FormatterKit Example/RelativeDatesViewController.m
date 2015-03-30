//
//  RelativeDatesViewController.m
//  FormatterKit Example
//
//  Created by Evan Flath on 3/27/15.
//  Copyright (c) 2015 Gowalla. All rights reserved.
//

#import "RelativeDatesViewController.h"
#import "TTTTimeIntervalFormatter.h"

@interface RelativeDatesViewController ()
@property (nonatomic, strong) UIDatePicker *fromPicker;
@property (nonatomic, strong) UIDatePicker *toPicker;
@property (nonatomic, strong) UILabel *fromLabel;
@property (nonatomic, strong) UILabel *toLabel;
@property (nonatomic, strong) UILabel *resultsLabel;
@property (nonatomic, strong) NSDate *fromDate;
@property (nonatomic, strong) NSDate *toDate;
@end

@implementation RelativeDatesViewController
@synthesize fromPicker, toPicker, fromLabel, toLabel, resultsLabel, fromDate, toDate;

-(instancetype)init {
    self = [super init];
    if (self) {
        self.fromDate = [NSDate date];
        self.toDate = [NSDate date];
    }
    return self;
}

-(void)loadView {
    [super loadView];
    self.fromPicker = [[UIDatePicker alloc] init];
    [self.view addSubview:self.fromPicker];

    self.toPicker = [[UIDatePicker alloc] init];
    [self.view addSubview:self.toPicker];

    self.fromLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.fromLabel.text = @"From:";
    [self.fromLabel sizeToFit];
    self.toLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.toLabel.text = @"To:";
    [self.toLabel sizeToFit];
    self.resultsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.resultsLabel.text = @"Results:";
    [self.resultsLabel sizeToFit];

    [self.view addSubview:fromLabel];
    [self.view addSubview:toLabel];
    [self.view addSubview:resultsLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.fromPicker addTarget:self
                        action:@selector(didChangeDatePicker:)
              forControlEvents:UIControlEventValueChanged];

    [self.toPicker addTarget:self
                        action:@selector(didChangeDatePicker:)
              forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGFloat y = self.topLayoutGuide.length;
    CGRect fromLabelRect = CGRectMake(0, y, bounds.size.width, 40);
    self.fromLabel.frame = fromLabelRect;
    y = CGRectGetMaxY(fromLabelRect);

    CGRect fromPickerRect = self.fromPicker.frame;
    fromPickerRect.origin.y = y;
    y += CGRectGetHeight(fromPickerRect);
    self.fromPicker.frame = fromLabelRect;

    CGRect toLabelRect = self.toLabel.frame;
    toLabelRect.origin.y = y;
    y += CGRectGetHeight(toLabelRect);
    self.toLabel.frame = toLabelRect;

    CGRect toPickerRect = self.toPicker.frame;
    toPickerRect.origin.y = y;
    y += CGRectGetHeight(toPickerRect);
    self.toPicker.frame = toPickerRect;

    CGRect resultsLabelRect = self.resultsLabel.frame;
    resultsLabelRect.origin.y = y;
    self.resultsLabel.frame = resultsLabelRect;

}

-(void)didChangeDatePicker:(id)sender {
    if (sender == self.fromPicker) {
        self.fromDate = self.fromPicker.date;
    }
    else if (sender == self.toPicker) {
        self.toDate = self.toPicker.date;
    }
    [self updateDateString];
}

-(void)updateDateString {
    static TTTTimeIntervalFormatter *_timeIntervalFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
        [_timeIntervalFormatter setLocale:[NSLocale currentLocale]];
        [_timeIntervalFormatter setUsesIdiomaticDeicticExpressions:YES];
    });

    if (self.fromDate && self.toDate) {
        NSString *dateString = [_timeIntervalFormatter stringForTimeIntervalFromDate:self.fromDate toDate:self.toDate];
        self.resultsLabel.text = [NSString stringWithFormat:@"Result: %@", dateString];
        [self.resultsLabel sizeToFit];
        [self.view setNeedsLayout];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
