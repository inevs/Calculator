#import "CalculatorViewController.h"
#import "CurrencyConverter.h"

#define Period @"."

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController
@synthesize currencyButtons;
@synthesize displayLabel;
@synthesize currencyLabel;

- (void)viewDidLoad {
	self.displayLabel.text = @"0";
	self.currency = CurrencyEuro;
}

- (IBAction)buttonTouched:(id)sender {
	NSMutableString *input = [self inputFromDisplay];
	NSString *character = [self characterFromButton:sender];
	if ([self shouldAppendCharacter:character toPreviousInput:input]) {
		[input appendString:character];
	}
	self.displayLabel.text = input;
}

- (IBAction)currencyButtonTouched:(id)sender {
	CGFloat value = [self.displayLabel.text floatValue];
	switch ([sender tag]) {
		case EuroButton:
	        self.currencyLabel.text = @"€";
	        value = [self.currencyConverter convertValue:value fromCurrency:self.currency toCurrency:CurrencyEuro];
	        self.currency = CurrencyEuro;
	        break;
		case DollarButton:
	        self.currencyLabel.text = @"$";
	        value = [self.currencyConverter convertValue:value fromCurrency:self.currency toCurrency:CurrencyDollar];
			self.currency = CurrencyDollar;
	        break;
		case YenButton:
			self.currencyLabel.text = @"¥";
	        value = [self.currencyConverter convertValue:value fromCurrency:self.currency toCurrency:CurrencyYen];
	        self.currency = CurrencyYen;
	        break;
		case GBPoundButton:
			self.currencyLabel.text = @"£";
	        value = [self.currencyConverter convertValue:value fromCurrency:self.currency toCurrency:CurrencyPound];
	        self.currency = CurrencyPound;
	        break;
		default:
	        break;
	}
	self.displayLabel.text = [NSString stringWithFormat:@"%1.2f", value];
	[self toggleEnablingOfButtonsRespectTo:sender];
}

- (void)toggleEnablingOfButtonsRespectTo:(id)sender {
	for (UIButton *button in self.currencyButtons) {
		button.enabled = YES;
	}
	[sender setEnabled:NO];
}

- (BOOL)shouldAppendCharacter:(NSString *)character toPreviousInput:(NSString *)input {
	BOOL result = YES;
	if ([character isEqualToString:Period] && [input rangeOfString:Period].location != NSNotFound) {
		result = NO;
	}
	return result;
}

- (NSString *)characterFromButton:(UIButton *)button {
	NSString *character = @"";
	if ([button tag] == PeriodButton) {
		character = Period;
	} else {
		character = [NSString stringWithFormat:@"%d", [button tag]];
	}
	return character;
}

- (NSMutableString *)inputFromDisplay {
	NSMutableString *input;
	NSString *previousInput = self.displayLabel.text;
	if ([previousInput isEqualToString:@"0"]) {
		input = [NSMutableString string];
	} else {
		input = [NSMutableString stringWithString:previousInput];
	}
	return input;
}

@end
