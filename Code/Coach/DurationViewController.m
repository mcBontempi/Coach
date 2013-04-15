#import "DurationViewController.h"

@interface DurationViewController ()
- (IBAction)nextPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *duration;
@property (weak, nonatomic) IBOutlet UITextField *name;

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

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  [self.name becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelPressed:(id)sender {
     [self dismissModalViewControllerAnimated:YES];
  
  [self.delegate DurationViewControllerDelegate_cancelled];
}

- (IBAction)nextPressed:(id)sender {
  
  NSInteger duration = [self.duration.text integerValue];
 
  if(duration >0 && duration <100 && self.name.text.length < 20 && self.name.text.length > 0){
    
     [self dismissModalViewControllerAnimated:YES];
  [self.delegate DurationViewControllerDelegate_finishedWith:[self.duration.text integerValue]  name:self.name.text] ;

      
 
  }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}
- (void)viewDidUnload {
  [self setName:nil];
  [super viewDidUnload];
}
@end
