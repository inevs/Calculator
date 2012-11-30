#import "CalculatorViewController.h"
#import "NSString+Utility.h"
#import "CurrencyRateRetriever.h"

#define Period @"."

@implementation CalculatorViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.displayLabel.text = @"0";
}

- (IBAction)buttonTouched:(id)sender {
	NSMutableString *input = [self inputFromDisplay];
	NSString *string = [self digitFromButton:sender];
	if ([self shouldAllowInputFromButton:sender withDisplayInput:input]) {
		[input appendString:string];
	}
	self.displayLabel.text = input;
}

- (BOOL)shouldAllowInputFromButton:(UIButton *)button withDisplayInput:(NSString *)input {
	return !([button tag] == PeriodButton && ([input containz:Period]));
}

- (NSMutableString *)inputFromDisplay {
	NSMutableString *input = [self.displayLabel.text mutableCopy];
	if (input == nil || [input isEqualToString:@"0"]) {
		input = [[NSMutableString alloc] init];
	}
	return input;
}

- (NSString *)digitFromButton:(UIButton *)button {
	NSString *string;
	if ([button tag] == PeriodButton) {
		string = Period;
	} else {
		string = [NSString stringWithFormat:@"%d", [button tag]];
	}
	return string;
}

- (IBAction)currencyButtonTouched:(id)sender {
	CGFloat input = [self.displayLabel.text floatValue];
	CGFloat rate = 0;
	if ([sender tag] == EuroDollarButton) {
		rate = [[self.currencyRateRetriever currencyRateFrom:@"EUR" to:@"USD"] floatValue];
	} else {
		rate = [[self.currencyRateRetriever currencyRateFrom:@"USD" to:@"EUR"] floatValue];
	}
	self.displayLabel.text = [NSString stringWithFormat:@"%1.3f", input * rate];
}

@end
