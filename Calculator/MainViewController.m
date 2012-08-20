#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize displayLabel;

- (IBAction)buttonTouched:(id)sender {
}
- (void)viewDidUnload {
    [self setDisplayLabel:nil];
    [super viewDidUnload];
}
@end
