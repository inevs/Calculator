#define EXP_SHORTHAND
#import "Expecta.h"

#define HC_SHORTHAND
#import <OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito.h>

#import <SenTestingKit/SenTestingKit.h>
#import "CalculatorViewController.h"
#import "CurrencyConverter.h"


@interface CalculatorTest : SenTestCase
@end

@implementation CalculatorTest {
	CalculatorViewController *calculatorViewController;
	UILabel *displayLabel;
	UILabel *currencyLabel;
}

- (void)setUp {
	calculatorViewController = [[CalculatorViewController alloc] init];
	displayLabel = [[UILabel alloc] init];
	displayLabel.text = @"";
	calculatorViewController.displayLabel = displayLabel;
	currencyLabel = [[UILabel alloc] init];
	calculatorViewController.currencyLabel = currencyLabel;
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

- (void)testDisplaysCurrencyInDisplay {
	[self assertThatButton:EuroButton displaysCurrency:@"€"];
	[self assertThatButton:DollarButton displaysCurrency:@"$"];
	[self assertThatButton:YenButton displaysCurrency:@"¥"];
	[self assertThatButton:GBPoundButton displaysCurrency:@"£"];
}

- (void)assertThatButton:(NSInteger)button displaysCurrency:(NSString *)currency {
	[calculatorViewController currencyButtonTouched:[self buttonWithTag:button]];
	expect(currencyLabel.text).to.equal(currency);
}

- (void)testDisablesCurrencyButtonOnTouch {
	UIButton *button = [self buttonWithTag:EuroButton];
	[calculatorViewController currencyButtonTouched:button];
	expect(button.enabled).to.beFalsy();
}

- (void)testEnablesAllOtherCurrencyButtonsOnCurrencyButtonTouch {
	UIButton *button1 = [self buttonWithTag:EuroButton];
	UIButton *button2 = [self buttonWithTag:YenButton];
	button2.enabled = NO;
	calculatorViewController.currencyButtons = @[button1, button2];
	[calculatorViewController currencyButtonTouched:button1];
	expect(button2.enabled).to.beTruthy();
}

- (void)testConvertsCurrentValueIntoCurrency {
	displayLabel.text = @"100.00";
	CurrencyConverter *converter = (id) mock([CurrencyConverter class]);
	[given([converter convertValue:100.0 fromCurrency:CurrencyEuro toCurrency:CurrencyDollar]) willReturnFloat:125.0];
	calculatorViewController.currencyConverter = converter;
	[calculatorViewController currencyButtonTouched:[self buttonWithTag:DollarButton]];
	expect(displayLabel.text).to.equal(@"125.00");

}
@end