#define PeriodButton 10
#define EqualsButton 11
#define SumButton 12
#define DifButton 13
#define MulButtom 14
#define DivButton 15
#define ClearButton 16
#define EuroDollarButton 17
#define DollarEuroButton 18

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

- (IBAction)buttonTouched:(id)sender;
- (IBAction)currencyButtonTouched:(id)sender;

@end
