#import "UtilViewController.h"

@interface UtilViewController ()
- (IBAction)getStartedPressed:(id)sender;

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
    
    [self.delegate UtilViewControllerDelegate_cancelPressed];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getStartedPressed:(id)sender {
    
    [self.delegate UtilViewControllerDelegate_getStartedPressed];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

@end
