#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController
@synthesize displayLabel;

- (void)viewDidLoad {
	self.displayLabel.text = @"0";
}

- (IBAction)buttonTouched:(id)sender {
	NSMutableString *input = [self inputFromDisplay];
	NSString *character = [self characterFromButton:sender respectingToInput:input];
	[input appendString:character];
	self.displayLabel.text = input;
}

- (NSString *)characterFromButton:(UIButton *)button respectingToInput:(NSString *)input {
	NSString *character = @"";
	if ([button tag] == PeriodButton) {
		if ([input rangeOfString:@"."].location == NSNotFound) {
			character = @".";
		}
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
