#import "CalculatorViewController.h"

#define Period @"."

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController
@synthesize displayLabel;

- (void)viewDidLoad {
	self.displayLabel.text = @"0";
}

- (IBAction)buttonTouched:(id)sender {
	NSMutableString *input = [self inputFromDisplay];
	NSString *character = [self characterFromButton:sender];
	if ([self shouldAppendCharacter:character toPreviousInput:input]) {
		[input appendString:character];
	}
	self.displayLabel.text = input;
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
