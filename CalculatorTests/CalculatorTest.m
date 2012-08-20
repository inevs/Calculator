#define EXP_SHORTHAND
#import "Expecta.h"

#import <SenTestingKit/SenTestingKit.h>
#import "CalculatorViewController.h"


@interface CalculatorTest : SenTestCase
@end

@implementation CalculatorTest {
	CalculatorViewController *calculatorViewController;
	UILabel *displayLabel;
}

- (void)setUp {
	calculatorViewController = [[CalculatorViewController alloc] init];
	displayLabel = [[UILabel alloc] init];
	calculatorViewController.displayLabel = displayLabel;
}

- (void)testShowsEmptyDisplayOnStart {
	[calculatorViewController viewDidLoad];
	expect(displayLabel.text).to.equal(@"0");
}

@end