#import "WelcomeViewController.h"

@interface WelcomeViewController ()
- (IBAction)getStartedPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *bodyText;

@end

@implementation WelcomeViewController{
  
  UIButton *testItButton;
  SlideToCancelViewController *slideToCancel;

}

-(id) init{
    NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
    [exception raise];
    return nil;
}

-(id) initWithDelegate:(id<WelcomeViewControllerDelegate>) delegate{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      if( [[UIScreen mainScreen] bounds].size.height == 568.0f){
        self = [super initWithNibName:@"WelcomeViewController_iPhone" bundle:nil];
      }else{
        self = [super initWithNibName:@"WelcomeViewController_iPhone4" bundle:nil];
      }
    } else {
        self = [super initWithNibName:@"WelcomeViewController_iPad" bundle:nil];
    }
    if(self){
        self.delegate = delegate;
    }
    
    return self;
}

- (void)viewDidLoad
{
  
  if (!slideToCancel) {
		// Create the slider
		slideToCancel = [[SlideToCancelViewController alloc] init];
		slideToCancel.delegate = self;
		
		// Position the slider off the bottom of the view, so we can slide it up
		CGRect sliderFrame = slideToCancel.view.frame;
		sliderFrame.origin.y = self.view.frame.size.height;
		slideToCancel.view.frame = sliderFrame;
		
		// Add slider to the view
		[self.view addSubview:slideToCancel.view];
	}
  
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                           target:self
                                                                                           action:@selector(cancel)] animated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
  self.bodyText.alpha = 0.0;
  
  self.slider.alpha = 0.0;
}

- (void) viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  [UIView animateWithDuration:4.0 animations:^{
    self.bodyText.alpha = 1.0;
    self.slider.alpha = 1.0;
  }];
  
  [self testIt];

  // [self close];
}

- (IBAction) testIt {
	// Start the slider animation
	slideToCancel.enabled = YES;
	testItButton.enabled = NO;
	
	// Slowly move up the slider from the bottom of the screen
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	CGPoint sliderCenter = slideToCancel.view.center;
	sliderCenter.y -= slideToCancel.view.bounds.size.height;
	slideToCancel.view.center = sliderCenter;
	[UIView commitAnimations];
}

// SlideToCancelDelegate method is called when the slider is slid all the way
// to the right
- (void) cancelled {
	// Disable the slider and re-enable the button
	slideToCancel.enabled = NO;
	testItButton.enabled = YES;
  
	// Slowly move down the slider off the bottom of the screen
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	CGPoint sliderCenter = slideToCancel.view.center;
	sliderCenter.y += slideToCancel.view.bounds.size.height;
	slideToCancel.view.center = sliderCenter;
	[UIView commitAnimations];
  
  
  [self performSelector:@selector(close) withObject:nil afterDelay:1.0];
  

  
}


- (void) close
{
  [self dismissViewControllerAnimated:YES completion:nil];
  
  [self.delegate WelcomeViewControllerDelegate_getStartedPressed];
}


-(void) cancel{
    
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getStartedPressed:(id)sender {
  

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

- (void)viewDidUnload {
  [self setSlider:nil];
  [self setBodyText:nil];
  [super viewDidUnload];
}
@end
