// TTTHoursOfOperation.m
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

#import "TTTHoursOfOperation.h"

@interface TTTHoursOfOperation : NSObject {}
+ (NSCalendar *)calendar;
+ (NSDateFormatter *)dateFormatter;
@end

@implementation TTTHoursOfOperation

+ (NSCalendar *)calendar {
    static NSCalendar *_calendar;
	if (!_calendar) {
		_calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	}
	
	return _calendar;
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *_dateFormatter;
	if (!_dateFormatter) {
		_dateFormatter = [[NSDateFormatter alloc] init];
		[_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
		[_dateFormatter setDateStyle:NSDateFormatterNoStyle];
		[_dateFormatter setLocale:[NSLocale currentLocale]];
	}
	
	return _dateFormatter;
}

@end

TTTWeekday TTTWeekdayForNSDate(NSDate *date) {
	NSDateComponents *components = [[TTTHoursOfOperation calendar] components:NSWeekdayCalendarUnit fromDate:date];
	return (TTTWeekday)[components weekday];
}

#pragma mark -
#pragma mark -

@interface TTTHoursOfOperationSegment ()
+ (NSString *)descriptionForSegments:(NSSet *)segments;
- (NSDateComponents *)openingDateComponents;
- (NSDateComponents *)closingDateComponents;
@end

@implementation TTTHoursOfOperationSegment
@synthesize openingHour = _openingHour;
@synthesize openingMinute = _openingMinute;
@synthesize closingHour = _closingHour;
@synthesize closingMinute = _closingMinute;

+ (id)hoursWithString:(NSString *)string {
	TTTHoursOfOperationSegment *dailyHours = [[[TTTHoursOfOperationSegment alloc] init] autorelease];
	
	NSCharacterSet *nonDecimalCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
	NSArray *components = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsSeparatedByCharactersInSet:nonDecimalCharacterSet];
	
	NSArray *openingComponents = [components subarrayWithRange:NSMakeRange(0, 2)];
	dailyHours.openingHour = [[[openingComponents objectAtIndex:0] stringByTrimmingCharactersInSet:nonDecimalCharacterSet] integerValue];
	dailyHours.openingMinute = [[[openingComponents lastObject] stringByTrimmingCharactersInSet:nonDecimalCharacterSet] integerValue];
	
	NSArray *closingComponents = [components subarrayWithRange:NSMakeRange(2, 2)];
	dailyHours.closingHour = [[[closingComponents objectAtIndex:0] stringByTrimmingCharactersInSet:nonDecimalCharacterSet] integerValue];
	dailyHours.closingMinute = [[[closingComponents lastObject] stringByTrimmingCharactersInSet:nonDecimalCharacterSet] integerValue];
	
	return dailyHours;
}

+ (NSString *)descriptionForSegments:(NSSet *)segments {
	NSSortDescriptor *hourSortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"openingHour" ascending:YES] autorelease];
	NSSortDescriptor *minuteSortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"openingMinute" ascending:YES] autorelease];
	NSArray *sortedSegments = [[segments allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:hourSortDescriptor, minuteSortDescriptor, nil]];
	
	return [[sortedSegments valueForKeyPath:@"description"] componentsJoinedByString:NSLocalizedString(@", ", @"(delimiter)")];
}

- (NSUInteger)hash {
	NSUInteger prime = 17;
	NSUInteger result = 1;
	
	result = prime + self.openingHour;
	result = prime * (result + self.openingMinute);
	result = prime * (result + self.closingHour);
	result = prime * (result + self.closingMinute);
	
	return result;
}

- (BOOL)isEqual:(id)object {
	if ([object isMemberOfClass:[self class]]) {
		return [object hash] == [self hash];
	}
	
	return [super isEqual:object];
}

- (NSString *)description {
	NSDateFormatter *dateFormatter = [TTTHoursOfOperation dateFormatter];
	
	return [NSString stringWithFormat:NSLocalizedString(@"%@ - %@", @"#{opening time} - #{closing time}"),[dateFormatter stringFromDate:[self openingDate]], [dateFormatter stringFromDate:[self closingDate]]];
}

- (NSDate *)openingDate {
	NSDateComponents *components = [[TTTHoursOfOperation calendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit 
																  fromDate:[NSDate date]];
	[components setHour:self.openingHour % 24];
	[components setMinute:self.openingMinute];
	
	return [[TTTHoursOfOperation calendar] dateFromComponents:components];
}

- (NSDateComponents *)openingDateComponents {
	NSDateComponents *dateComponents = [[[NSDateComponents alloc] init] autorelease];
	[dateComponents setHour:self.openingHour];
	[dateComponents setMinute:self.openingMinute];
	
	return dateComponents;
}

- (NSDate *)closingDate {
	NSDateComponents *components = [[TTTHoursOfOperation calendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit 
																  fromDate:[NSDate date]];
	[components setHour:self.closingHour % 24];
	[components setMinute:self.closingMinute];
	
	return [[TTTHoursOfOperation calendar] dateFromComponents:components];
}

- (NSDateComponents *)closingDateComponents {
	NSDateComponents *dateComponents = [[[NSDateComponents alloc] init] autorelease];
	[dateComponents setHour:self.closingHour];
	[dateComponents setMinute:self.closingMinute];
	
	return dateComponents;
}

@end

#pragma mark -

@interface TTTDailyHoursOfOperation ()
@property (nonatomic, assign) TTTWeekday weekday;
@property (nonatomic, retain) NSSet *segments;
@property (readonly) NSString *weekdaySymbol;

- (id)initWithWeekday:(TTTWeekday)someWeekday;
- (BOOL)hasSameHoursAsDailyHours:(TTTDailyHoursOfOperation *)dailyHours;
@end

@implementation TTTDailyHoursOfOperation
@synthesize weekday = _weekday;
@synthesize closed = _closed;
@synthesize segments = _segments;
@dynamic weekdaySymbol;
@dynamic hasDefinedHours;

+ (id)hoursWithString:(NSString *)string forWeekday:(TTTWeekday)someWeekday {
	TTTDailyHoursOfOperation *dailyHours = [[[self class] alloc] initWithWeekday:someWeekday];
	
	if ([string isEqualToString:@"closed"]) {
		dailyHours.closed = YES;
		return [dailyHours autorelease];
	}
	
	NSMutableSet *mutableSegments = [[dailyHours.segments mutableCopy] autorelease];
	for (NSString *componentSubstring in [string componentsSeparatedByString:@","]) {
		[mutableSegments addObject:[TTTHoursOfOperationSegment hoursWithString:componentSubstring]];
	}
	dailyHours.segments = [NSSet setWithSet:mutableSegments];
	
	return [dailyHours autorelease];
}

- (id)initWithWeekday:(TTTWeekday)someWeekday {
	self = [super init];
	if (!self) {
		return nil;
	}
	
	self.weekday = someWeekday;
	self.segments = [NSSet set];
	
	return self;
}

- (void)dealloc {
	[_segments release];
	[super dealloc];
}

- (NSString *)description {
	if (self.closed) {
		return [NSString stringWithFormat:NSLocalizedString(@"%@: Closed", @"#{weekday}: Closed"), self.weekdaySymbol];
	} else {
		return [NSString stringWithFormat:NSLocalizedString(@"%@: %@", @"#{weekday}: {#{opening} - #{closing}}"), self.weekdaySymbol, [TTTHoursOfOperationSegment descriptionForSegments:self.segments]];
	}	
}

- (NSString *)weekdaySymbol {
	return [[[TTTHoursOfOperation dateFormatter] shortWeekdaySymbols] objectAtIndex:(NSUInteger)(self.weekday - 1)];
}

- (BOOL)hasDefinedHours {
	return [self.segments count] == 0 && !self.closed;
}

- (BOOL)hasSameHoursAsDailyHours:(TTTDailyHoursOfOperation *)dailyHours {
	return [self.segments isEqualToSet:[dailyHours segments]];
}

@end


#pragma mark -
#pragma mark -

@interface TTTWeeklyHoursOfOperation ()
@property (nonatomic, retain) TTTDailyHoursOfOperation *sundayHours;
@property (nonatomic, retain) TTTDailyHoursOfOperation *mondayHours;
@property (nonatomic, retain) TTTDailyHoursOfOperation *tuesdayHours;
@property (nonatomic, retain) TTTDailyHoursOfOperation *wednesdayHours;
@property (nonatomic, retain) TTTDailyHoursOfOperation *thursdayHours;
@property (nonatomic, retain) TTTDailyHoursOfOperation *fridayHours;
@property (nonatomic, retain) TTTDailyHoursOfOperation *saturdayHours;
@end

@implementation TTTWeeklyHoursOfOperation
@synthesize sundayHours = _sundayHours;
@synthesize mondayHours = _mondayHours;
@synthesize tuesdayHours = _tuesdayHours;
@synthesize wednesdayHours = _wednesdayHours;
@synthesize thursdayHours = _thursdayHours;
@synthesize fridayHours = _fridayHours;
@synthesize saturdayHours = _saturdayHours;

- (id)init {
	self = [super init];
	if (!self) {
		return nil;
	}
	
	self.sundayHours = [[[TTTDailyHoursOfOperation alloc] initWithWeekday:TTTSunday] autorelease];
	self.mondayHours = [[[TTTDailyHoursOfOperation alloc] initWithWeekday:TTTMonday] autorelease];
	self.tuesdayHours = [[[TTTDailyHoursOfOperation alloc] initWithWeekday:TTTTuesday] autorelease];
	self.wednesdayHours = [[[TTTDailyHoursOfOperation alloc] initWithWeekday:TTTWednesday] autorelease];
	self.thursdayHours = [[[TTTDailyHoursOfOperation alloc] initWithWeekday:TTTThursday] autorelease];
	self.fridayHours = [[[TTTDailyHoursOfOperation alloc] initWithWeekday:TTTFriday] autorelease];
	self.saturdayHours = [[[TTTDailyHoursOfOperation alloc] initWithWeekday:TTTSaturday] autorelease];
	
	return self;
}

- (TTTDailyHoursOfOperation *)hoursForWeekday:(TTTWeekday)weekday {
	switch (weekday) {
		case TTTSunday:
			return self.sundayHours;
		case TTTMonday:
			return self.mondayHours;
		case TTTTuesday:
			return self.tuesdayHours;
		case TTTWednesday:
			return self.wednesdayHours;
		case TTTThursday:
			return self.thursdayHours;
		case TTTFriday:
			return self.fridayHours;
		case TTTSaturday:
			return self.saturdayHours;
		default:
			return nil;
	}
}

- (void)setHoursWithString:(NSString *)string forWeekday:(TTTWeekday)weekday {
	TTTDailyHoursOfOperation *dailyHours = [TTTDailyHoursOfOperation hoursWithString:string forWeekday:weekday];
	
	switch (weekday) {
		case TTTSunday:
			self.sundayHours = dailyHours;
			break;
		case TTTMonday:
			self.mondayHours = dailyHours;
			break;
		case TTTTuesday:
			self.tuesdayHours = dailyHours;
			break;
		case TTTWednesday:
			self.wednesdayHours = dailyHours;
			break;
		case TTTThursday:
			self.thursdayHours = dailyHours;
			break;
		case TTTFriday:
			self.fridayHours = dailyHours;
			break;
		case TTTSaturday:
			self.saturdayHours = dailyHours;
			break;
	}
}

- (NSString *)description {		
	NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
		return ![(TTTDailyHoursOfOperation *)evaluatedObject hasDefinedHours];
	}];
	NSArray *hoursForAllDays = [[NSArray arrayWithObjects:self.mondayHours, self.tuesdayHours, self.wednesdayHours, self.thursdayHours, self.fridayHours, self.saturdayHours, self.sundayHours, nil] filteredArrayUsingPredicate:predicate];
	
	NSMutableArray *mutableDescriptions = [NSMutableArray array];
	NSEnumerator *enumerator = [hoursForAllDays objectEnumerator];
	TTTDailyHoursOfOperation *dailyHours, *candidateDailyHours;
	
	while (dailyHours = [enumerator nextObject]) {
		NSMutableArray *groupedHours = [NSMutableArray arrayWithObject:dailyHours];
		while ((candidateDailyHours = [enumerator nextObject]) && [dailyHours hasSameHoursAsDailyHours:candidateDailyHours]) {
			[groupedHours addObject:candidateDailyHours];
		}
		
		if (candidateDailyHours) {
			enumerator = [[hoursForAllDays subarrayWithRange:NSMakeRange([hoursForAllDays indexOfObject:candidateDailyHours], [hoursForAllDays count] - [hoursForAllDays indexOfObject:candidateDailyHours])] objectEnumerator];
		}
		
		NSString *label = nil;
		if ([groupedHours count] == 7) {
			label = NSLocalizedString(@"Everyday", nil);
		} else if ([groupedHours count] == 5 && [[groupedHours lastObject] weekday] == TTTFriday) {
			label = NSLocalizedString(@"Weekdays", nil);
		} else if ([groupedHours count] == 2 && [[groupedHours lastObject] weekday] == TTTSunday) {
			label = NSLocalizedString(@"Weekends", nil);
		} else {
			if ([groupedHours count] > 2) {
				label = [NSString stringWithFormat:NSLocalizedString(@"%@ - %@", @"(weekday range)"), [[groupedHours objectAtIndex:0] weekdaySymbol], [[groupedHours lastObject] weekdaySymbol]];
			} else {
				for (TTTDailyHoursOfOperation *someDailyHours in groupedHours) {
					[mutableDescriptions addObject:[someDailyHours description]];
				}
				
				continue;
			}
		}
		
		NSString *value = nil;
		if ([[groupedHours lastObject] isClosed]) {
			value = NSLocalizedString(@"Closed", nil);
		} else {
			value = [TTTHoursOfOperationSegment descriptionForSegments:[[groupedHours lastObject] segments]];
		}
		
		[mutableDescriptions addObject:[NSString stringWithFormat:NSLocalizedString(@"%@: %@", @"#{label}: {#{opening} - #{closing}}"), label, value]];				  
	}
	
	return [mutableDescriptions componentsJoinedByString:@"\n"];
}

- (BOOL)isTimeWithinOpeningHours:(NSDate *)time {
	NSDateComponents *components = [[TTTHoursOfOperation calendar] components:NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:time];
	TTTDailyHoursOfOperation *dailyHours = [self hoursForWeekday:(TTTWeekday)[components weekday]];
	
	for (TTTHoursOfOperationSegment *segment in dailyHours.segments) {
		if ([components hour] > segment.openingHour && [components hour] < segment.closingHour) {
			return YES;
		} else if ([components hour] == segment.openingHour && [components minute] >= segment.openingMinute) {
			return YES;
		} else if ([components hour] == segment.closingHour && [components minute] <= segment.closingMinute) {
			return YES;
		}
	}
	
	return NO;
}

- (BOOL)isCurrentTimeWithinOpeningHours {
	return [self isTimeWithinOpeningHours:[NSDate date]];
}

@end
