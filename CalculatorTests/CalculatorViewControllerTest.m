#import "CalculatorViewController.h"
#import "CurrencyRateRetriever.h"

@interface CalculatorViewControllerTest : SenTestCase
@end

@implementation CalculatorViewControllerTest {
	CalculatorViewController *calculatorViewController;
	UILabel *displayLabel;
	id currencyRateRetriever;
}

- (void)setUp {
	calculatorViewController = [[CalculatorViewController alloc] init];
	displayLabel = [[UILabel alloc] init];
	calculatorViewController.displayLabel = displayLabel;
	currencyRateRetriever = mock([CurrencyRateRetriever class]);
	calculatorViewController.currencyRateRetriever = currencyRateRetriever;
}

- (UIButton *)buttonWithTag:(NSInteger)tag {
	UIButton *button = [[UIButton alloc] init];
	button.tag = tag;
	return button;
}

- (void)testSetsDisplayToZeroOnLoad {
	[calculatorViewController viewDidLoad];
	expect(displayLabel.text).equal(@"0");
}

- (void)testEntersDigitsIntoDisplay {
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

- (void)testInsertsDecimalWithPeriod {
	displayLabel.text = @"1";
	[calculatorViewController buttonTouched:[self buttonWithTag:PeriodButton]];
	expect(displayLabel.text).equal(@"1.");
}

- (void)testAvoidsMultiplePeriods {
	displayLabel.text = @"1.";
	[calculatorViewController buttonTouched:[self buttonWithTag:PeriodButton]];
	expect(displayLabel.text).equal(@"1.");
}

- (void)testAsksForRateEurToUsd {
	[calculatorViewController currencyButtonTouched:[self buttonWithTag:EuroDollarButton]];
	[verify(currencyRateRetriever) currencyRateFrom:@"EUR" to:@"USD"];
}

- (void)testAsksForUsdToEur {
	[calculatorViewController currencyButtonTouched:[self buttonWithTag:DollarEuroButton]];
	[verify(currencyRateRetriever) currencyRateFrom:@"USD" to:@"EUR"];
}

- (void)testConvertsEuroToDollar {
	displayLabel.text = @"23.5";
	[given([currencyRateRetriever currencyRateFrom:@"EUR" to:@"USD"]) willReturn:@1.25];
	[calculatorViewController currencyButtonTouched:[self buttonWithTag:EuroDollarButton]];
	expect(displayLabel.text).equal(@"29.375");
}

- (void)testConvertsDollarToEuro {
	displayLabel.text = @"17.3";
	[given([currencyRateRetriever currencyRateFrom:@"USD" to:@"EUR"]) willReturn:@2.5];
	[calculatorViewController currencyButtonTouched:[self buttonWithTag:DollarEuroButton]];
	expect(displayLabel.text).equal(@"43.250");
}
@end