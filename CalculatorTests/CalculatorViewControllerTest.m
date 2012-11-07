#import "CalculatorViewController.h"

@interface CalculatorViewControllerTest : SenTestCase
@end

@implementation CalculatorViewControllerTest {
	CalculatorViewController *calculatorViewController;
	UILabel *displayLabel;
}

- (void)setUp {
	calculatorViewController = [[CalculatorViewController alloc] init];
	displayLabel = [[UILabel alloc] init];
	calculatorViewController.displayLabel = displayLabel;
}

- (UIButton *)buttonWithTag:(NSInteger)tag {
	UIButton *button = [[UIButton alloc] init];
	button.tag = tag;
	return button;
}

- (void)testSetsDisplayToZeroOnStart {
	[calculatorViewController viewDidLoad];
	expect(displayLabel.text).equal(@"0");
}

- (void)testEntersDigitIntoDisplay {
	[calculatorViewController buttonTouched:[self buttonWithTag:1]];
	expect(displayLabel.text).equal(@"1");
}

- (void)testAppendsDigitsToDisplay {
	[calculatorViewController buttonTouched:[self buttonWithTag:2]];
	[calculatorViewController buttonTouched:[self buttonWithTag:3]];
	expect(displayLabel.text).equal(@"23");
}

- (void)testAvoidsTrailingZero {
	displayLabel.text = @"0";
	[calculatorViewController buttonTouched:[self buttonWithTag:4]];
	expect(displayLabel.text).equal(@"4");
}

- (void)testEntersPeriod {
	displayLabel.text = @"1";
	[calculatorViewController buttonTouched:[self buttonWithTag:PeriodButton]];
	expect(displayLabel.text).equal(@"1.");
}

- (void)testAvoidsMutliplePeriods {
	displayLabel.text = @"1.";
	[calculatorViewController buttonTouched:[self buttonWithTag:PeriodButton]];
	expect(displayLabel.text).equal(@"1.");
}

@end