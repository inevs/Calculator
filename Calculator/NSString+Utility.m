#import "NSString+Utility.h"


@implementation NSString (Utility)
- (BOOL)containz:(NSString *)string {
	return [self rangeOfString:string].location != NSNotFound;
}

@end