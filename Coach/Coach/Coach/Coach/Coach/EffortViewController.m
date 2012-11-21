#import "EffortViewController.h"

@interface EffortViewController ()

- (IBAction)easyPressed:(id)sender;

- (IBAction)intermediatePressed:(id)sender;

- (IBAction)competitivePressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *Effort;

@end

@implementation EffortViewController

-(id) init{
    NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
    [exception raise];
    return nil;
}

-(id) initWithDelegate:(id<EffortViewControllerDelegate>) delegate{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [super initWithNibName:@"EffortViewController_iPhone" bundle:nil];
    } else {
        self = [super initWithNibName:@"EffortViewController_iPad" bundle:nil];
    }
    if(self){
        self.delegate = delegate;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextPressed:(id)sender {
    [self.delegate EffortViewControllerDelegate_effortPressed:ETypeSprint];
}

- (void)viewDidUnload {
    [self setEffort:nil];
    [super viewDidUnload];
}
- (IBAction)easyPressed:(id)sender {
    [self.delegate EffortViewControllerDelegate_effortPressed:EEffortEasy];
}

- (IBAction)intermediatePressed:(id)sender {
    [self.delegate EffortViewControllerDelegate_effortPressed:EEffortIntermediate];
}

- (IBAction)competitivePressed:(id)sender {
    [self.delegate EffortViewControllerDelegate_effortPressed:EEffortCompetitive];
}
@end
