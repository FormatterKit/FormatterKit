// LocationFormatterViewController.m
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

#import <CoreLocation/CoreLocation.h>
#import "LocationFormatterViewController.h"

#import "TTTLocationFormatter.h"

NS_ENUM(NSUInteger, LocationFormatterViewControllerSectionIndexes) {
    CoordinatesSignedDegreesSectionIndex,
    CoordinatesDegreesWithDirectionSectionIndex,
    CoordinatesDegreesMinutesSecondsWithDirectionSectionIndex,
    DistanceInMetricWithCardinalDirectionsSectionIndex,
    DistanceInImperialWithcardinalDirectionAbbreviationsSectionIndex,
    SpeedInImperialWithBearingsInDegreesSectionIndex,
};

@implementation LocationFormatterViewController

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }

    self.title = NSLocalizedString(@"Location Formatter", nil);

    return self;
}

+ (NSString *)formatterDescription {
    return NSLocalizedString(@"TTTLocationFormatter gives you a lot of flexibility in the display of coordinates, distances, direction, speed, and velocity. Choose Metric or Imperial, cardinal directions, abbreviations, or degrees, and configure everything else (number of significant digits, etc.), with the associated NSNumberFormatter.", nil);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(__unused UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case CoordinatesSignedDegreesSectionIndex:
            return NSLocalizedString(@"Coordinates (Signed Degrees)", nil);
        case CoordinatesDegreesWithDirectionSectionIndex:
            return NSLocalizedString(@"Coordinates (Degrees + Compass Direction)", nil);
        case CoordinatesDegreesMinutesSecondsWithDirectionSectionIndex:
            return NSLocalizedString(@"Coordinates (Degrees / Minutes / Seconds + Compass Direction)", nil);
        case DistanceInMetricWithCardinalDirectionsSectionIndex:
            return NSLocalizedString(@"Distance in Metric Units, with Cardinal Directions", nil);
        case DistanceInImperialWithcardinalDirectionAbbreviationsSectionIndex:
            return NSLocalizedString(@"Distance in Imperial Units, with Cardinal Direction Abbreviations", nil);
        case SpeedInImperialWithBearingsInDegreesSectionIndex:
            return NSLocalizedString(@"Speed in Imperial Units, with Bearing in Degrees", nil);
        default:
            return nil;
    }
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    static TTTLocationFormatter *_locationFormatter = nil;
    static CLLocation *_austin = nil;
    static CLLocation *_pittsburgh = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _locationFormatter = [[TTTLocationFormatter alloc] init];
        [_locationFormatter.numberFormatter setMaximumSignificantDigits:4];
        [_locationFormatter.numberFormatter setUsesSignificantDigits:YES];

        _austin = [[CLLocation alloc] initWithLatitude:30.2669444 longitude:-97.7427778];
        _pittsburgh = [[CLLocation alloc] initWithLatitude:40.4405556 longitude:-79.9961111];
    });

    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;

    switch (indexPath.section) {
        case CoordinatesSignedDegreesSectionIndex:
            _locationFormatter.coordinateStyle = TTTSignedDegreesFormat;

            cell.textLabel.text = [_locationFormatter stringFromLocation:_austin];
            break;
        case CoordinatesDegreesWithDirectionSectionIndex:
            _locationFormatter.coordinateStyle = TTTDegreesFormat;

            cell.textLabel.text = [_locationFormatter stringFromLocation:_austin];
            break;
        case CoordinatesDegreesMinutesSecondsWithDirectionSectionIndex:
            _locationFormatter.coordinateStyle = TTTDegreesMinutesSecondsFormat;

            cell.textLabel.text = [_locationFormatter stringFromLocation:_austin];
            break;
        case DistanceInMetricWithCardinalDirectionsSectionIndex:
            [_locationFormatter setUnitSystem:TTTMetricSystem];
            [_locationFormatter setBearingStyle:TTTBearingWordStyle];

            cell.textLabel.text = [_locationFormatter stringFromDistanceAndBearingFromLocation:_pittsburgh toLocation:_austin];
            break;
        case DistanceInImperialWithcardinalDirectionAbbreviationsSectionIndex:
            [_locationFormatter setUnitSystem:TTTImperialSystem];
            [_locationFormatter setBearingStyle:TTTBearingAbbreviationWordStyle];

            cell.textLabel.text = [_locationFormatter stringFromDistanceAndBearingFromLocation:_pittsburgh toLocation:_austin];
            break;
        case SpeedInImperialWithBearingsInDegreesSectionIndex:
            [_locationFormatter setUnitSystem:TTTImperialSystem];
            [_locationFormatter setBearingStyle:TTTBearingNumericStyle];

            cell.textLabel.text = [_locationFormatter stringFromVelocityFromLocation:_pittsburgh toLocation:_austin atSpeed:25];
            break;
    }
}

@end
