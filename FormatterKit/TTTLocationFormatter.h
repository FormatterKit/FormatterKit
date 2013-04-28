// TTTLocationFormatter.h
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

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 Specifies the ordering of latitude and longitude in coordinate pairs.
 */
typedef enum {
    TTTCoordinateLatLngOrder = 0,
    TTTCoordinateLngLatOrder,
} TTTLocationFormatterCoordinateOrder;

/**
 Specifies the style used when formatting bearing into a string.
 */
typedef enum {
    TTTBearingWordStyle = 0,            // e.g. "Southwest"
    TTTBearingAbbreviationWordStyle,    // e.g. "SW"
    TTTBearingNumericStyle,             // e.g. "225°"
} TTTLocationFormatterBearingStyle;

/**
 Specifies the style used when formatting distance into a string.
 */
typedef enum {
    TTTDistanceWordStyle = 0,           // e.g. "kilometers"
    TTTDistanceAbbreviationWordStyle,   // e.g. "km"
} TTTLocationFormatterDistanceStyle;

/**
 Specifies the units used to express distance in formatted strings.
 */
typedef enum {
    TTTMetricSystem = 0,    // Expresses distance in meters and kilometers.
    TTTImperialSystem,      // Expresses distance in feet, yards, and miles.
} TTTLocationUnitSystem;

/**
 Defines the cardinal directions.
 */
typedef enum {
    TTTNorthDirection,
    TTTNortheastDirection,
    TTTEastDirection,
    TTTSoutheastDirection,
    TTTSouthDirection,
    TTTSouthwestDirection,
    TTTWestDirection,
    TTTNorthwestDirection,
} TTTLocationCardinalDirection;

/**
 Converts a specified bearing from degrees into its closest cardinal direction.
 */
extern TTTLocationCardinalDirection TTTLocationCardinalDirectionFromBearing(CLLocationDegrees bearing);

/**
 Instances of `TTTLocationFormatter` create localized string representations of `CLLocationCoordinate2D`, `CLLocationDistance`, `CLLocationDegrees`, and `CLLocationSpeed` values and `CLLocation` objects.

 For example, if Imperial units were specified, a distance of 1960 meters at a bearing of 225° would be formatted as @"1,218 Miles Southwest" in English.
 */
@interface TTTLocationFormatter : NSFormatter

/**
 Specifies the `NSNumberFormatter` object used to format numeric values in all formatted strings. By default, this uses the current system locale with the `NSNumberFormatterDecimalStyle` number style, and displays 2 significant digits.
 */
@property (readonly, nonatomic, strong) NSNumberFormatter *numberFormatter;

/**
 Specifies the ordering of latitude and longitude values in coordinate pairs. `TTTCoordinateLatLngOrder` by default.
 */
@property (nonatomic, assign) TTTLocationFormatterCoordinateOrder coordinateOrder;

/**
 Specifies the formatting of bearing in strings. `TTTBearingWordStyle` by default.
 */
@property (nonatomic, assign) TTTLocationFormatterBearingStyle bearingStyle;

/**
 Specifies the formatting of distance in strings. `TTTDistanceAbbreviationWordStyle` by default.
 */
@property (nonatomic, assign) TTTLocationFormatterDistanceStyle distanceStyle;

/**
 Specifies the units used to express distance in formatted strings. `TTTMetricSystem` by default.
 */
@property (nonatomic, assign) TTTLocationUnitSystem unitSystem;

/**
 Returns a string representation of a given coordinate formatted using the receiver’s current settings.

 @param coordinate The coordinate to format.
 */
- (NSString *)stringFromCoordinate:(CLLocationCoordinate2D)coordinate;

/**
 Returns a string representation of a given location formatted using the receiver’s current settings.

 @param location The location to format.
 */
- (NSString *)stringFromLocation:(CLLocation *)location;

/**
 Returns a string representation of a given distance formatted using the receiver’s current settings.

 @param distance The distance to format.
 */
- (NSString *)stringFromDistance:(CLLocationDistance)distance;

/**
 Returns a string representation of a given bearing formatted using the receiver’s current settings.

 @param bearing The bearing to format.
 */
- (NSString *)stringFromBearing:(CLLocationDegrees)bearing;

/**
 Returns a string representation of a given speed formatted using the receiver’s current settings.

 @param speed The speed to format.
 */
- (NSString *)stringFromSpeed:(CLLocationSpeed)speed;

/**
 Returns a string representation of the distance between two specified locations formatted using the receiver’s current settings.

 @param originLocation The starting location.
 @param destinationLocation The final location.
 */
- (NSString *)stringFromDistanceFromLocation:(CLLocation *)originLocation
                                  toLocation:(CLLocation *)destinationLocation;

/**
 Returns a string representation of the bearing between two specified locations formatted using the receiver’s current settings.

 @param originLocation The starting location.
 @param destinationLocation The final location.
 */
- (NSString *)stringFromBearingFromLocation:(CLLocation *)originLocation
                                 toLocation:(CLLocation *)destinationLocation;

/**

 */
- (NSString *)stringFromDistanceAndBearingFromLocation:(CLLocation *)originLocation
                                            toLocation:(CLLocation *)destinationLocation;

/**
 Returns a string representation of the velocity traveling between two specified locations at a given speed formatted using the receiver’s current settings.

 @param originLocation The starting location.
 @param destinationLocation The final location.
 @param speed The speed used to travel between the specified locations.
 */
- (NSString *)stringFromVelocityFromLocation:(CLLocation *)originLocation
                                  toLocation:(CLLocation *)destinationLocation
                                     atSpeed:(CLLocationSpeed)speed;

@end
