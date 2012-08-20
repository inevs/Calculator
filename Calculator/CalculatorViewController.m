#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController
@synthesize displayLabel;

- (IBAction)buttonTouched:(id)sender {
}
- (void)viewDidUnload {
    [self setDisplayLabel:nil];
    [super viewDidUnload];
}
@end
