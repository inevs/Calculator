#import "CalculatorViewController.h"
#import "NSString+Utils.h"

#define PeriodDigit @"."

@implementation CalculatorViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.displayLabel.text = @"0";
}

- (IBAction)buttonTouched:(id)sender {
	NSMutableString *display = [self inputFromDisplay];
	NSString *digit = [self digitFromButton:sender];
	if ([self shouldAppendDigit:digit toDisplay:display]) {
		[display appendString:digit];
	}
	self.displayLabel.text = display;
}

- (BOOL)shouldAppendDigit:(NSString *)digit toDisplay:(NSMutableString *)display {
	if ([digit isEqualToString:PeriodDigit]) {
		return [display contains:PeriodDigit];
	}
	return YES;
}

- (NSString *)digitFromButton:(UIButton *)button {
	NSString *digit;
	if ([button tag] <= 9) {
		digit = [NSString stringWithFormat:@"%d", [button tag]];
	} else {
		digit = PeriodDigit;
	}
	return digit;
}

- (NSMutableString *)inputFromDisplay {
	NSMutableString *input = [self.displayLabel.text mutableCopy];
	if (!input || [input isEqualToString:@"0"]) {
		input = [[NSMutableString alloc] init];
	}
	return input;
}

- (IBAction)currencyButtonTouched:(id)sender {
}

@end
