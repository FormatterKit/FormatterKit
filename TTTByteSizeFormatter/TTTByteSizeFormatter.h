//
//  HZByteSizeFormatter.h
//  ByteSizeFormatter
//
//  Created by Hector Zarate Rea on 1/1/12.
//  Copyright (c) 2012 mieldemaple.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TTTByteSizeFormatter : NSFormatter

-(NSString *)stringWithNumberOfBytes:(NSUInteger)theNumberOfBytes;


@end