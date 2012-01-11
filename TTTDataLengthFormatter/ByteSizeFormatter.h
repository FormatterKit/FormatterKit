//
//  HZByteSizeFormatter.h
//  ByteSizeFormatter
//
//  Created by Hector Zarate Rea on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HZByteSizeFormatter : NSFormatter
{
    NSUInteger resultResolution;
    
    HZByteSizeFormatterUnitStyle unitStyle;
}

-(NSString *)stringWithNumberOfBytes:(NSUInteger)theNumberOfBytes;


@end
