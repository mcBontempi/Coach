#import "UtilViewController.h"

@interface UtilViewController ()
- (IBAction)exportPressed:(id)sender;
- (IBAction)makePlanPressed:(id)sender;

@end

@implementation UtilViewController

-(id) init{
    NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
    [exception raise];
    return nil;
}

-(id) initWithDelegate:(id<UtilViewControllerDelegate>) delegate{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [super initWithNibName:@"UtilViewController_iPhone" bundle:nil];
    } else {
        self = [super initWithNibName:@"UtilViewController_iPad" bundle:nil];
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
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                           target:self
                                                                                           action:@selector(cancel)] animated:YES];
}

-(void) cancel{
    
    [self.delegate UtilViewControllerDelegate_cancel];
    
}


- (IBAction)exportPressed:(id)sender {
    
    [self.delegate UtilViewControllerDelegate_export];
}

- (IBAction)makePlanPressed:(id)sender {
  [self.delegate UtilViewControllerDelegate_makeEmptyPlan:5];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

@end
