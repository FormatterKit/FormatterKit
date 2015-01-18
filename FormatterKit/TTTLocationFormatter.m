// TTTLocationFormatter.m
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

#import "TTTLocationFormatter.h"

static double const kTTTMetersToKilometersCoefficient = 0.001;
static double const kTTTMetersToFeetCoefficient = 3.2808399;
static double const kTTTMetersToYardsCoefficient = 1.0936133;
static double const kTTTMetersToMilesCoefficient = 0.000621371192;

static inline double CLLocationDistanceToKilometers(CLLocationDistance distance) {
    return distance * kTTTMetersToKilometersCoefficient;
}

static inline double CLLocationDistanceToFeet(CLLocationDistance distance) {
    return distance * kTTTMetersToFeetCoefficient;
}

static inline double CLLocationDistanceToYards(CLLocationDistance distance) {
    return distance * kTTTMetersToYardsCoefficient;
}

static inline double CLLocationDistanceToMiles(CLLocationDistance distance) {
    return distance * kTTTMetersToMilesCoefficient;
}

#pragma mark -

static inline double DEG2RAD(double degrees) {
    return degrees * M_PI / 180;
}

static inline double RAD2DEG(double radians) {
    return radians * 180 / M_PI;
}

static inline void TTTGetDegreesMinutesSecondsFromCoordinateDegrees(CLLocationDegrees degrees, double *d, double *m, double *s) {
    double r;

    *d = trunc(degrees);
    r = fabs(degrees - *d);

    *m = 60.0 * r;
    r = *m - floor(*m);

    *s = 60.0 * r;
}

static inline void TTTGetCardinalDirectionsFromCoordinate(CLLocationCoordinate2D coordinate, TTTLocationCardinalDirection *latitudeDirection, TTTLocationCardinalDirection *longitudeDirection) {
    *latitudeDirection = coordinate.latitude >= 0.0 ? TTTNorthDirection : TTTSouthDirection;
    *longitudeDirection = coordinate.longitude >= 0.0 ? TTTEastDirection : TTTWestDirection;
}

static inline CLLocationDegrees CLLocationDegreesBearingBetweenCoordinates(CLLocationCoordinate2D originCoordinate, CLLocationCoordinate2D destinationCoordinate) {
    double lat1 = DEG2RAD(originCoordinate.latitude);
	double lon1 = DEG2RAD(originCoordinate.longitude);
	double lat2 = DEG2RAD(destinationCoordinate.latitude);
	double lon2 = DEG2RAD(destinationCoordinate.longitude);

    double dLon = lon2 - lon1;
	double y = sin(dLon) * cos(lat2);
	double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
	double bearing = atan2(y, x) + (2 * M_PI);

    // `atan2` works on a range of -π to 0 to π, so add on 2π and perform a modulo check
	if (bearing > (2 * M_PI)) {
		bearing = bearing - (2 * M_PI);
	}

	return RAD2DEG(bearing);
}

TTTLocationCardinalDirection TTTLocationCardinalDirectionFromBearing(CLLocationDegrees bearing) {
    if(bearing > 337.5) {
        return TTTNorthDirection;
    } else if(bearing > 292.5) {
        return TTTNorthwestDirection;
    } else if(bearing > 247.5) {
        return TTTWestDirection;
    } else if(bearing > 202.5) {
        return TTTSouthwestDirection;
    } else if(bearing > 157.5) {
        return TTTSouthDirection;
    } else if(bearing > 112.5) {
        return TTTSoutheastDirection;
    } else if(bearing > 67.5) {
        return TTTEastDirection;
    } else if(bearing > 22.5) {
        return TTTNortheastDirection;
    } else {
        return TTTNorthDirection;
    }
}

#pragma mark -

static double const kTTTMetersPerSecondToKilometersPerHourCoefficient = 3.6;
static double const kTTTMetersPerSecondToFeetPerSecondCoefficient = 3.2808399;
static double const kTTTMetersPerSecondToMilesPerHourCoefficient = 2.23693629;

static inline double CLLocationSpeedToKilometersPerHour(CLLocationSpeed speed) {
    return speed * kTTTMetersPerSecondToKilometersPerHourCoefficient;
}

static inline double CLLocationSpeedToFeetPerSecond(CLLocationSpeed speed) {
    return speed * kTTTMetersPerSecondToFeetPerSecondCoefficient;
}

static inline double CLLocationSpeedToMilesPerHour(CLLocationSpeed speed) {
    return speed * kTTTMetersPerSecondToMilesPerHourCoefficient;
}

#pragma mark -

static NSString * TTTLocalizedStringForCardinalDirection(TTTLocationCardinalDirection direction) {
    switch (direction) {
        case TTTNorthDirection:
            return NSLocalizedStringFromTable(@"North", @"FormatterKit", @"North Direction");
        case TTTNortheastDirection:
            return NSLocalizedStringFromTable(@"Northeast", @"FormatterKit", @"Northeast Direction");
        case TTTEastDirection:
            return NSLocalizedStringFromTable(@"East", @"FormatterKit", @"East Direction");
        case TTTSoutheastDirection:
            return NSLocalizedStringFromTable(@"Southeast", @"FormatterKit", @"Southeast Direction");
        case TTTSouthDirection:
            return NSLocalizedStringFromTable(@"South", @"FormatterKit", @"South Direction");
        case TTTSouthwestDirection:
            return NSLocalizedStringFromTable(@"Southwest", @"FormatterKit", @"Southwest Direction");
        case TTTWestDirection:
            return NSLocalizedStringFromTable(@"West", @"FormatterKit", @"West Direction");
        case TTTNorthwestDirection:
            return NSLocalizedStringFromTable(@"Northwest", @"FormatterKit", @"Northwest Direction");
        default:
            return nil;
    }
}

static NSString * TTTLocalizedStringForAbbreviatedCardinalDirection(TTTLocationCardinalDirection direction) {
    switch (direction) {
        case TTTNorthDirection:
            return NSLocalizedStringFromTable(@"N", @"FormatterKit", @"North Direction Abbreviation");
        case TTTNortheastDirection:
            return NSLocalizedStringFromTable(@"NE", @"FormatterKit", @"Northeast Direction Abbreviation");
        case TTTEastDirection:
            return NSLocalizedStringFromTable(@"E", @"FormatterKit", @"East Direction Abbreviation");
        case TTTSoutheastDirection:
            return NSLocalizedStringFromTable(@"SE", @"FormatterKit", @"Southeast Direction Abbreviation");
        case TTTSouthDirection:
            return NSLocalizedStringFromTable(@"S", @"FormatterKit", @"South Direction Abbreviation");
        case TTTSouthwestDirection:
            return NSLocalizedStringFromTable(@"SW", @"FormatterKit", @"Southwest Direction Abbreviation");
        case TTTWestDirection:
            return NSLocalizedStringFromTable(@"W", @"FormatterKit", @"West Direction Abbreviation");
        case TTTNorthwestDirection:
            return NSLocalizedStringFromTable(@"NW", @"FormatterKit", @"Northwest Direction Abbreviation");
        default:
            return nil;
    }
}

@interface TTTLocationFormatter ()
@property (readwrite, nonatomic, strong) NSNumberFormatter *numberFormatter;
@end

@implementation TTTLocationFormatter
@synthesize numberFormatter = _numberFormatter;
@synthesize coordinateOrder = _coordinateOrder;
@synthesize coordinateStyle = _coordinateStyle;
@synthesize bearingStyle = _bearingStyle;
@synthesize unitSystem = _unitSystem;

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.coordinateOrder = TTTCoordinateLatLngOrder;
    self.bearingStyle = TTTBearingWordStyle;

    BOOL usesMetricSystem = [[(NSLocale *)[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue];
    self.unitSystem = usesMetricSystem ? TTTMetricSystem : TTTImperialSystem;

    _numberFormatter = [[NSNumberFormatter alloc] init];
    [_numberFormatter setLocale:[NSLocale currentLocale]];
    [_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [_numberFormatter setMaximumSignificantDigits:2];
    [_numberFormatter setUsesSignificantDigits:YES];

    return self;
}

#pragma mark -

- (NSString *)stringFromCoordinate:(CLLocationCoordinate2D)coordinate {
    NSString *latitudeString = nil;
    NSString *longitudeString = nil;

    switch (self.coordinateStyle) {
        case TTTSignedDegreesFormat:
            latitudeString = [self.numberFormatter stringFromNumber:@(coordinate.latitude)];
            longitudeString = [self.numberFormatter stringFromNumber:@(coordinate.longitude)];
            break;
        case TTTDegreesFormat: {
            static NSString * TTTDegreesFormatString = @"%@° %@";
            TTTLocationCardinalDirection latitudeDirection, longitudeDirection;
            TTTGetCardinalDirectionsFromCoordinate(coordinate, &latitudeDirection, &longitudeDirection);
            latitudeString = [NSString stringWithFormat:TTTDegreesFormatString, [self.numberFormatter stringFromNumber:@(fabs(coordinate.latitude))], TTTLocalizedStringForAbbreviatedCardinalDirection(latitudeDirection)];
            longitudeString = [NSString stringWithFormat:TTTDegreesFormatString, [self.numberFormatter stringFromNumber:@(fabs(coordinate.longitude))], TTTLocalizedStringForAbbreviatedCardinalDirection(longitudeDirection)];
            break;
        }
        case TTTDegreesMinutesSecondsFormat: {
            static NSString * TTTDegreesMinutesSecondsFormatString = @"%d° %d′ %@″ %@";
            double degrees, minutes, seconds;
            TTTLocationCardinalDirection latitudeDirection, longitudeDirection;
            TTTGetCardinalDirectionsFromCoordinate(coordinate, &latitudeDirection, &longitudeDirection);

            TTTGetDegreesMinutesSecondsFromCoordinateDegrees(coordinate.latitude, &degrees, &minutes, &seconds);
            latitudeString = [NSString stringWithFormat:TTTDegreesMinutesSecondsFormatString, (NSInteger)degrees, (NSInteger)minutes, [self.numberFormatter stringFromNumber:@(seconds)], TTTLocalizedStringForAbbreviatedCardinalDirection(latitudeDirection)];

            TTTGetDegreesMinutesSecondsFromCoordinateDegrees(coordinate.longitude, &degrees, &minutes, &seconds);
            longitudeString = [NSString stringWithFormat:TTTDegreesMinutesSecondsFormatString, (NSInteger)degrees, (NSInteger)minutes, [self.numberFormatter stringFromNumber:@(seconds)], TTTLocalizedStringForAbbreviatedCardinalDirection(longitudeDirection)];
            break;
        }
        default:
            break;
    }

    switch (self.coordinateOrder) {
        case TTTCoordinateLatLngOrder:
            return [NSString stringWithFormat:@"%@, %@", latitudeString, longitudeString];
            break;
        case TTTCoordinateLngLatOrder:
            return [NSString stringWithFormat:@"%@, %@", longitudeString, latitudeString];
        default:
            return nil;;
    }
}

- (NSString *)stringFromLocation:(CLLocation *)location {
    return [self stringFromCoordinate:location.coordinate];
}

- (NSString *)stringFromDistance:(CLLocationDistance)distance {
    NSString *distanceString = nil;
    NSString *unitString = nil;

    switch (self.unitSystem) {
        case TTTMetricSystem: {
            double meterDistance = distance;
            double kilometerDistance = CLLocationDistanceToKilometers(distance);

            if (kilometerDistance >= 1) {
                distanceString = [_numberFormatter stringFromNumber:@(kilometerDistance)];
                unitString = NSLocalizedStringFromTable(@"km", @"FormatterKit", @"Kilometer Unit");
            } else {
                distanceString = [_numberFormatter stringFromNumber:@(meterDistance)];
                unitString = NSLocalizedStringFromTable(@"m", @"FormatterKit", @"Meter Unit");
            }
            break;
        }

        case TTTImperialSystem: {
            double feetDistance = CLLocationDistanceToFeet(distance);
            double yardDistance = CLLocationDistanceToYards(distance);
            double milesDistance = CLLocationDistanceToMiles(distance);

            if (feetDistance < 300) {
                distanceString = [_numberFormatter stringFromNumber:@(feetDistance)];
                unitString = NSLocalizedStringFromTable(@"ft", @"FormatterKit", @"Feet Unit");
            } else if (yardDistance < 500) {
                distanceString = [_numberFormatter stringFromNumber:@(yardDistance)];
                unitString = NSLocalizedStringFromTable(@"yds", @"FormatterKit", @"Yard Unit");
            } else {
                distanceString = [_numberFormatter stringFromNumber:@(milesDistance)];
                unitString = (milesDistance > 1.0 && milesDistance < 1.1) ? NSLocalizedStringFromTable(@"mile", @"FormatterKit", @"Mile Unit (Singular)") : NSLocalizedStringFromTable(@"miles", @"FormatterKit", @"Mile Unit (Plural)");
            }
            break;
        }
    }

    return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"Distance Format String", @"FormatterKit", [NSBundle mainBundle], @"%@ %@", @"#{Distance} #{Unit}"), distanceString, unitString];
}

- (NSString *)stringFromBearing:(CLLocationDegrees)bearing {
    switch (self.bearingStyle) {
        case TTTBearingWordStyle:
            return TTTLocalizedStringForCardinalDirection(TTTLocationCardinalDirectionFromBearing(bearing));
        case TTTBearingAbbreviationWordStyle:
            return TTTLocalizedStringForAbbreviatedCardinalDirection(TTTLocationCardinalDirectionFromBearing(bearing));
        case TTTBearingNumericStyle:
            return [self.numberFormatter stringFromNumber:@(bearing)];
    }

    return nil;
}

- (NSString *)stringFromSpeed:(CLLocationSpeed)speed {
    NSString *speedString = nil;
    NSString *unitString = nil;

    switch (self.unitSystem) {
        case TTTMetricSystem: {
            double metersPerSecondSpeed = speed;
            double kilometersPerHourSpeed = CLLocationSpeedToKilometersPerHour(speed);

            if (kilometersPerHourSpeed > 1) {
                speedString = [self.numberFormatter stringFromNumber:@(kilometersPerHourSpeed)];
                unitString = NSLocalizedStringFromTable(@"km/h", @"FormatterKit", @"Kilometers Per Hour Unit");
            } else {
                speedString = [self.numberFormatter stringFromNumber:@(metersPerSecondSpeed)];
                unitString = NSLocalizedStringFromTable(@"m/s", @"FormatterKit", @"Meters Per Second Unit");
            }
            break;
        }

        case TTTImperialSystem: {
            double feetPerSecondSpeed = CLLocationSpeedToFeetPerSecond(speed);
            double milesPerHourSpeed = CLLocationSpeedToMilesPerHour(speed);

            if (milesPerHourSpeed > 1) {
                speedString = [self.numberFormatter stringFromNumber:@(milesPerHourSpeed)];
                unitString = NSLocalizedStringFromTable(@"mph", @"FormatterKit", @"Miles Per Hour Unit");
            } else {
                speedString = [self.numberFormatter stringFromNumber:@(feetPerSecondSpeed)];
                unitString = NSLocalizedStringFromTable(@"ft/s", @"FormatterKit", @"Feet Per Second Unit");
            }
            break;
        }
    }

    return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"Speed Format String", @"FormatterKit", [NSBundle mainBundle], @"%@ %@", @"#{Speed} #{Unit}"), speedString, unitString];
}

- (NSString *)stringFromDistanceFromLocation:(CLLocation *)originLocation
                                  toLocation:(CLLocation *)destinationLocation
{
    return [self stringFromDistance:[destinationLocation distanceFromLocation:originLocation]];
}

- (NSString *)stringFromBearingFromLocation:(CLLocation *)originLocation
                                 toLocation:(CLLocation *)destinationLocation
{
    return [self stringFromBearing:CLLocationDegreesBearingBetweenCoordinates(originLocation.coordinate, destinationLocation.coordinate)];
}

- (NSString *)stringFromDistanceAndBearingFromLocation:(CLLocation *)originLocation
                                            toLocation:(CLLocation *)destinationLocation
{
    return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"Dimension Format String", @"FormatterKit", [NSBundle mainBundle], @"%@ %@", @"#{Dimensional Quantity} #{Direction}"), [self stringFromDistanceFromLocation:originLocation toLocation:destinationLocation], [self stringFromBearingFromLocation:originLocation toLocation:destinationLocation]];
}

- (NSString *)stringFromVelocityFromLocation:(CLLocation *)originLocation
                                  toLocation:(CLLocation *)destinationLocation
                                     atSpeed:(CLLocationSpeed)speed
{
    return [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"Dimension Format String", @"FormatterKit", [NSBundle mainBundle], @"%@ %@", @"#{Dimensional Quantity} #{Direction}"), [self stringFromSpeed:speed], [self stringFromBearingFromLocation:originLocation toLocation:destinationLocation]];
}

#pragma mark - NSFormatter

- (NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[CLLocation class]]) {
        return nil;
    }

    return [self stringFromLocation:(CLLocation *)anObject];
}

- (BOOL)getObjectValue:(out __unused __autoreleasing id *)obj
             forString:(__unused NSString *)string
      errorDescription:(out NSString *__autoreleasing *)error
{
    *error = NSLocalizedStringFromTable(@"Method Not Implemented", @"FormatterKit", nil);

    return NO;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    TTTLocationFormatter *formatter = [[[self class] allocWithZone:zone] init];

    formatter.numberFormatter = [self.numberFormatter copyWithZone:zone];
    formatter.coordinateOrder = self.coordinateOrder;
    formatter.bearingStyle = self.bearingStyle;
    formatter.unitSystem = self.unitSystem;

    return formatter;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    self.numberFormatter = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(numberFormatter))];
    self.coordinateOrder = (TTTLocationFormatterCoordinateOrder)[aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(coordinateOrder))];
    self.bearingStyle = (TTTLocationFormatterBearingStyle)[aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(bearingStyle))];
    self.unitSystem = (TTTLocationUnitSystem)[aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(unitSystem))];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:self.numberFormatter forKey:NSStringFromSelector(@selector(numberFormatter))];
    [aCoder encodeInteger:self.coordinateOrder forKey:NSStringFromSelector(@selector(coordinateOrder))];
    [aCoder encodeInteger:self.bearingStyle forKey:NSStringFromSelector(@selector(bearingStyle))];
    [aCoder encodeInteger:self.unitSystem forKey:NSStringFromSelector(@selector(unitSystem))];
}

@end
