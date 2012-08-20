#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController
@synthesize displayLabel;

- (IBAction)buttonTouched:(id)sender {
}

- (void)viewDidLoad {
	self.displayLabel.text = @"0";
}


@end
