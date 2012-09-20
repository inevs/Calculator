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
	displayLabel.text = @"";
	calculatorViewController.displayLabel = displayLabel;
}

- (UIButton *)buttonWithTag:(NSInteger)tag {
	UIButton *button = [[UIButton alloc] init];
	button.tag = tag;
	return button;
}

- (void)testShowsEmptyDisplayOnStart {
	[calculatorViewController viewDidLoad];
	expect(displayLabel.text).to.equal(@"0");
}

- (void)testAppendsDigitsToInput {
	[calculatorViewController buttonTouched:[self buttonWithTag:1]];
	expect(displayLabel.text).to.equal(@"1");
}

- (void)testAppendsMultipleDigits {
	[calculatorViewController buttonTouched:[self buttonWithTag:2]];
	[calculatorViewController buttonTouched:[self buttonWithTag:3]];
	expect(displayLabel.text).to.equal(@"23");
}

- (void)testAvoidsTrailingZero {
	displayLabel.text = @"0";
	[calculatorViewController buttonTouched:[self buttonWithTag:4]];
	expect(displayLabel.text).to.equal(@"4");
}

- (void)testInsertsDecimalWithPeriod {
	displayLabel.text = @"1";
	[calculatorViewController buttonTouched:[self buttonWithTag:PeriodButton]];
	expect(displayLabel.text).to.equal(@"1.");
}

- (void)testAllowsOnlyOnePeriod {
	displayLabel.text = @"1.";
	[calculatorViewController buttonTouched:[self buttonWithTag:PeriodButton]];
	expect(displayLabel.text).to.equal(@"1.");
}

- (void)testAllowsOnlyOnePeriodInInput {
	displayLabel.text = @"4.56";
	[calculatorViewController buttonTouched:[self buttonWithTag:PeriodButton]];
	expect(displayLabel.text).to.equal(@"4.56");
}

@end