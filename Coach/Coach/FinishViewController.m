#import "FinishViewController.h"


@interface FinishViewController () 
- (IBAction)getStartedPressed:(id)sender;
- (IBAction)makePlanPressed:(id)sender;
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

- (IBAction)getStartedPressed:(id)sender {
    
    [self.delegate FinishViewControllerDelegate_getStartedPressed];
}

- (IBAction)makePlanPressed:(id)sender {
    
    self.makePlanButton.hidden = YES;
    [self.delegate FinishViewControllerDelegate_makePlanPressed];
}


-(void) ToFinishViewControllerDelegate_planCreated{
    self.getStartedButton.hidden = NO;
    
}

- (void)viewDidUnload {
    [self setMakePlanButton:nil];
    [self setGetStartedButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

@end
