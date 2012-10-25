#import "DurationViewController.h"

@interface DurationViewController ()
- (IBAction)nextPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *duration;

@end

@implementation DurationViewController

-(id) init{
    NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
    [exception raise];
    return nil;
}

-(id) initWithDelegate:(id<DurationViewControllerDelegate>) delegate{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [super initWithNibName:@"DurationViewController_iPhone" bundle:nil];
    } else {
        self = [super initWithNibName:@"DurationViewController_iPad" bundle:nil];
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
    
    [self.delegate DurationViewControllerDelegate_nextPressed:[self.duration.text intValue]];
}

- (void)viewDidUnload {
    [self setDuration:nil];
    [super viewDidUnload];
}
@end
