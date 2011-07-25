# FormatterKit

`FormatterKit` is a collection of well-crafted `NSFormatter` subclasses for things like hours of operation, distance, and relative time intervals. Each formatter abstracts away the complex business logic of their respective domain, so that you can focus on the more important aspects of your application.

In short, use this library if you're manually formatting any of the following (with string interpolation or the like):

* __Arrays__: Display `NSArray` elements in a comma-delimited list *(eg. "Russell, Spinoza & Rawls")*
* __Hours of Operation__: Format and collapse recurring weekly business hours *(eg. "Mon-Wed: 8:00AM - 7:00PM")*
* __Location, Distance & Direction__: Show `CLLocationDistance`, `CLLocationDirection`, and `CLLocationSpeed` in metric or imperial units *(eg. "240ft Northwest" / "45 km/h SE")*
* __Ordinal Numbers__: Convert cardinal `NSNumber` objects to their ordinal in most major languages *(eg. "1st, 2nd, 3rd" / "1ère, 2ème, 3ème")*
* __Time Intervals__: Show relative time distance between any two `NSDate` objects *(eg. "3 minutes ago" / "yesterday")*
* __URL Requests__: Print out `cURL` or `Wget` command equivalents for any `NSURLRequest` *(eg. `curl "https://api.gowalla.com/spots/" -H "Accept: application/json"`)*

---

## TTTArrayFormatter

Think of this as a production-ready alternative to `NSArray -componentsJoinedByString:`. `TTTArrayFormatter` comes with internationalization baked-in, and provides a concise API that allows you to configure for any edge cases.

### Example Usage

``` objective-c
NSArray *list = [NSArray arrayWithObjects:@"Russel", @"Spinoza", @"Rawls", nil];
TTTArrayFormatter *arrayFormatter = [[[TTTArrayFormatter alloc] init] autorelease];
[arrayFormatter setUsesAbbreviatedConjunction:YES]; // Use '&' instead of 'and'
[arrayFormatter setUsesSerialDelimiter:NO]; // Omit Oxford Comma
NSLog(@"%@", [arrayFormatter stringFromArray:list]); // # => "Russell, Spinoza & Rawls"
```

## TTTHoursOfOperation

Modeling and displaying hours of operation is tricky business. It's perhaps one of the most prolific ratholes that has ever existed--a trap that has ensnared many a venturing programmer with its tendrils of perceived simplicity and maddening edge-cases.

TTTHoursOfOperation makes it easy to programmatically do the following:

    Mon-Wed: 8:00AM - 7:00PM
    Thu: 9:00AM - 12:00PM, 3:00PM - 10:00PM
    Fri: Closed
    Weekends: 11:00AM - 1:00AM

Additional features include:
- Built-in hours parser to handle simply-formatted input, such as `"08:45-15:00,17:00-22:00"` or `"closed"`
- Check if the current time is within today's store hours, or get the NSDates associated with this weeks hours for a particular weekday
- Wrap-around time support, i.e. `"20:00-26:00"` would be the hours 8PM - 2AM, associated with a specified weekday
- Localized output, such that a Japanese user, for example would see hours in a format like "火: 8:00 - 20:00" or "閉店"

### Example Usage

``` objective-c
TTTWeeklyHoursOfOperation *hoursOfOperation = [[TTTWeeklyHoursOfOperation alloc] init];
[self.hoursOfOperation setHoursWithString:@"08:00-19:00" forWeekday:TTTMonday];
[self.hoursOfOperation setHoursWithString:@"08:00-19:00" forWeekday:TTTTuesday];
[self.hoursOfOperation setHoursWithString:@"08:00-19:00" forWeekday:TTTWednesday];
[self.hoursOfOperation setHoursWithString:@"09:00-12:00,15:00-22:00" forWeekday:TTTThursday];
[self.hoursOfOperation setHoursWithString:@"closed" forWeekday:TTTFriday];
[self.hoursOfOperation setHoursWithString:@"11:00-25:00" forWeekday:TTTSaturday];
[self.hoursOfOperation setHoursWithString:@"11:00-25:00" forWeekday:TTTSunday];
```

## TTTLocationFormatter

When working with `CoreLocation`, you can use your favorite unit for distance... so long as your favorite unit is the meter. If you want to take distance calculations and display them to the user, you may want to use kilometers instead, or maybe even miles, if you're of the [Imperial](http://en.wikipedia.org/wiki/Imperial_units) persuasion.

`TTTLocationFormatter` gives you a lot of flexibility in the display of coordinates, distances, direction, speed, and velocity. Choose Metric or Imperial, cardinal directions, abbreviations, or degrees, and configure everything else (number of significant digits, etc.), with the associated `NSNumberFormatter`.

### Example Usage

``` objective-c
TTTLocationFormatter *locationFormatter = [[[TTTLocationFormatter alloc] init] autorelease];
CLLocation *austin = [[[CLLocation alloc] initWithLatitude:30.2669444 longitude:-97.7427778] autorelease];
CLLocation *pittsburgh = [[[CLLocation alloc] initWithLatitude:40.4405556 longitude:-79.9961111] autorelease];
```

#### Distance in Metric Units with Cardinal Directions

``` objective-c
NSLog(@"%@", [locationFormatter stringFromDistanceAndBearingFromLocation:pittsburgh toLocation:austin]);
// "2,000 km Southwest"
```

#### Distance in Imperial Units with Cardinal Direction Abbreviations

``` objective-c
[locationFormatter.numberFormatter setMaximumSignificantDigits:4];
[locationFormatter setBearingStyle:TTTBearingAbbreviationWordStyle];
[locationFormatter setUnitSystem:TTTImperialSystem];
NSLog(@"%@", [locationFormatter stringFromDistanceAndBearingFromLocation:pittsburgh toLocation:austin]);
// "1,218 miles SW"
```

#### Speed in Imperial Units with Bearing in Degrees

[locationFormatter setBearingStyle:TTTBearingNumericStyle];
NSLog(@"%@ at %@", [locationFormatter stringFromSpeed:25],[locationFormatter stringFromBearingFromLocation:pittsburgh toLocation:austin]);
// "25 mph at 310°"

#### Coordinates

``` objective-c
[locationFormatter setUsesSignificantDigits:NO];
NSLog(@"%@", [locationFormatter stringFromLocation:austin]);
// (30.2669444, -97.7427778)
```

## TTTOrdinalNumberFormatter

Core Foundation's NSNumberFormatter is great for [Cardinal numbers](http://en.wikipedia.org/wiki/Cardinal_number) (17, 42, 69, etc.), but it doesn't have built-in support for [Ordinal numbers](http://en.wikipedia.org/wiki/Ordinal_number_(linguistics)) (1st, 2nd, 3rd, etc.)

A naïve implementation might be as simple as throwing the one's place in a switch statement and appending "-st", "-nd", etc. But what if you want to support French, which appends "-er", "-ère", and "-eme" in various contexts? How about Spanish? Japanese?

`TTTOrdinalNumberFormatter` supports English, Spanish, French, Irish, Italian, Japanese, Dutch, Portuguese, and Mandarin Chinese. For other languages, you can use the standard default, or override it with your own. For languages whose ordinal indicator depends upon the grammatical properties of the predicate, `TTTOrdinalNumberFormatter` can format according to a specified gender and/or plurality.

### Example Usage

``` objective-c
TTTOrdinalNumberFormatter *ordinalNumberFormatter = [[TTTOrdinalNumberFormatter alloc] init];
[ordinalNumberFormatter setLocale:[NSLocale currentLocale]];
[ordinalNumberFormatter setGrammaticalGender:TTTOrdinalNumberFormatterMaleGender];
NSNumber *number = [NSNumber numberWithInteger:2];
NSLog(@"%@", [NSString stringWithFormat:NSLocalizedString(@"You came in %@ place!", nil), [ordinalNumberFormatter stringFromNumber:number]]);
```

Assuming you've provided localized strings for "You came in %@ place!", the output would be:

- English: "You came in 2nd place!"
- French: "Vous êtes venu à la 2eme place!"
- Spanish: "Usted llegó en 2.o lugar!"

## TTTTimeIntervalFormatter

Nearly every application works with time in some way or another, and most often when we display temporal information to users, it's in relative terms to the present. So "3 minutes ago", "10 months ago", or "last month".

iOS 4 introduced a `-doesRelativeDateFormatting` property for `NSDateFormatter`, but it falls back on an absolute time representation if no idiomatic expression is found.  Instead, `TTTTimeIntervalFormatter` defaults to a smart relative display of an `NSTimeInterval` value, with options to extend that behavior to your particular use case.

### Example Usage

``` objective-c
TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
[timeIntervalFormatter stringForTimeInterval:0]; // "just now"
[timeIntervalFormatter stringForTimeInterval:100]; // "1 minute ago"
[timeIntervalFormatter stringForTimeInterval:8000]; // "2 hours ago"

// Turn idiomatic deictic expressions on / off
[timeIntervalFormatter stringForTimeInterval:100000]; // "yesterday"
[timeIntervalFormatter setUsesIdiomaticDeicticExpressions:NO];
[timeIntervalFormatter stringForTimeInterval:100000]; // "1 day ago"

// Customize the present tense deictic expression for
[timeIntervalFormatter setPresentDeicticExpression:@"seconds ago"];
[timeIntervalFormatter stringForTimeInterval:0]; // "seconds ago"

// Expand the time interval for present tense
[timeIntervalFormatter stringForTimeInterval:3]; // "3 seconds ago"
[timeIntervalFormatter setPresentTimeIntervalMargin:3]; 
[timeIntervalFormatter stringForTimeInterval:3]; // "seconds ago"
```

## TTTURLRequestFormatter

`NSURLRequest` objects encapsulate all of the information made in a network request, including url, headers, body, etc. This isn't something you'd normally want to show to a user, but it'd be nice to have a way to make it more portable for debugging.

Enter `TTTURLRequestFormatter`. In addition to formatting requests simply as `GET http://api.gowalla.com/spots`, it will also generate `cURL` and `Wget` commands with all of its headers and data fields intact to debug in the console.

### Example Usage

``` objective-c
NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWith
[request setHTTPMethod:@"POST"];
[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
[TTTURLRequestFormatter cURLCommandFromURLRequest:request];
```

    curl -X POST "https://api.gowalla.com/spots/" -H "Accept: application/json"

---

## License

FormatterKit is licensed under the MIT License:

  Copyright (c) 2011 Mattt Thompson (http://mattt.me/)

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
