#import "FinishViewController.h"


@interface FinishViewController () 
- (IBAction)getStartedPressed:(id)sender;
- (IBAction)makePlan:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *makePlanButton;
@property (weak, nonatomic) IBOutlet UIButton *getStartedButton;

@end

@implementation FinishViewController

-(id) init{
    NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
    [exception raise];
    return nil;
}

-(id) initWithDelegate:(id<FinishViewControllerDelegate>) delegate{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [super initWithNibName:@"FinishViewController_iPhone" bundle:nil];
    } else {
        self = [super initWithNibName:@"FinishViewController_iPad" bundle:nil];
    }
    if(self){
        self.delegate = delegate;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.getStartedButton.hidden = YES;
    self.makePlanButton.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getStartedPressed:(id)sender {
    
    [self.delegate FinishViewControllerDelegate_getStartedPressed];
    
    
}

- (IBAction)makePlan:(id)sender {
    
    self.makePlanButton.hidden = YES;
    [self.delegate FinishViewControllerDelegate_makePlanPressed];
}


-(void) planCreated{
    self.getStartedButton.hidden = NO;
    
}

- (void)viewDidUnload {
    [self setMakePlanButton:nil];
    [self setGetStartedButton:nil];
    [super viewDidUnload];
}
@end
