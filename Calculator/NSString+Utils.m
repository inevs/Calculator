#import "NSString+Utils.h"


@implementation NSString (Utils)

- (BOOL)contains:(NSString *)string {
	return [self rangeOfString:string].location == NSNotFound;
}

@end
