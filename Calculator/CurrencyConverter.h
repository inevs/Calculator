#import <Foundation/Foundation.h>

typedef enum {
	CurrencyEuro,
	CurrencyDollar,
	CurrencyYen,
	CurrencyPound
} Currency;

@interface CurrencyConverter : NSObject
- (CGFloat)convertValue:(CGFloat)value fromCurrency:(Currency)fromCurrency toCurrency:(Currency)toCurrency;
@end