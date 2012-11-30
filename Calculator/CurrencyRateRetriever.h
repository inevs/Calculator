#import <Foundation/Foundation.h>


@interface CurrencyRateRetriever : NSObject

- (NSNumber *)currencyRateFrom:(NSString *)from to:(NSString *)to;
@end