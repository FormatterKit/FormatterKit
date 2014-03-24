//
//  TTTJSONFormatter.m
//  
//
//  Created by griffin-stewie on 2014/03/18.
//
//

#import "TTTJSONFormatter.h"

@implementation TTTJSONFormatter

+ (NSString *)jqCommandFromJSON:(id)JSON {
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:JSON options:0 error:NULL];

    return [self jqCommandFromJSONData:JSONData];
}

+ (NSString *)jqCommandFromJSONString:(NSString *)JSONString {
    NSString *result = [NSString stringWithFormat:@"cat <<'END' | jq '.' \n%@ \nEND", JSONString];
    
    return result;
}

+ (NSString *)jqCommandFromJSONData:(NSData *)JSONData {
    NSString *JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];

    return [self jqCommandFromJSONString:JSONString];
}
@end
