//
//  HZByteSizeFormatter.m
//  ByteSizeFormatter
//
//  Created by Hector Zarate Rea on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TTTByteSizeFormatter.h"

#define kNumberOfBytesInKBytes 1024.0

@implementation ByteSizeFormatter

-(id)init
{
    self = [super init];
    
    if (!self)
    {
        return nil;
    }
    
    return self;
}

-(NSString *)stringWithNumberOfBytes:(NSUInteger)numberOfBytes
{
    NSArray *abbreviatedSuffix = [NSArray arrayWithObjects:@"b", 
                                  @"Kb",
                                  @"Mb",
                                  @"Gb",
                                  @"Tb",
                                  @"Pb",
                                  nil];
    
    
    double tempNumberOfUnits = numberOfBytes;
    
    NSString *result = nil;
    
    NSString *suffix = [abbreviatedSuffix objectAtIndex:0];
    
    // Automatic Unit:
    for (int i=1; tempNumberOfUnits >= kHZNumberOfBytesInKBytes; i++)
    {
        suffix = [abbreviatedSuffix objectAtIndex:i];
        tempNumberOfUnits = tempNumberOfUnits / kHZNumberOfBytesInKBytes;
    }
    
    if (tempNumberOfUnits - floorf(tempNumberOfUnits) == 0)
    {
        result = [NSString stringWithFormat:@"%0.0f %@", tempNumberOfUnits, suffix];                
    }
    else
    {
        result = [NSString stringWithFormat:@"%0.2f %@", tempNumberOfUnits, suffix];        
    }
    
    
    return result;   
}



@end