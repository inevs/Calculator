#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController
@synthesize displayLabel;

- (void)viewDidLoad {
	self.displayLabel.text = @"0";
}

- (IBAction)buttonTouched:(id)sender {
	NSMutableString *input;
	NSString *previousInput = self.displayLabel.text;
	if ([previousInput isEqualToString:@"0"]) {
		input = [NSMutableString string];
	} else {
		input = [NSMutableString stringWithString:previousInput];
	}
	[input appendFormat:@"%d", [sender tag]];
	self.displayLabel.text = input;
}


@end
