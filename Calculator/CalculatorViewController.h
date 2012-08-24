#import "CurrencyConverter.h"

@class CurrencyConverter;
#define PeriodButton 10
#define EqualsButton 11
#define SumButton 12
#define DifButton 13
#define MulButtom 14
#define DivButton 15
#define ClearButton 16
#define EuroButton 17
#define DollarButton 18
#define YenButton 19
#define GBPoundButton 20

@interface CalculatorViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *currencyButtons;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;
@property (nonatomic, strong) CurrencyConverter *currencyConverter;
@property (nonatomic) Currency currency;
- (IBAction)buttonTouched:(id)sender;
- (IBAction)currencyButtonTouched:(id)sender;

@end
