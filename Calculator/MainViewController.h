
#define PeriodButton 10
#define EqualsButton 11
#define SumButton 12
#define DifButton 13
#define MulButtom 14
#define DivButton 15
#define ClearButton 16
#define MemClearButton 17
#define MemSumButton 18
#define MemDifButton 19
#define MemResultButton 20

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
- (IBAction)buttonTouched:(id)sender;

@end
