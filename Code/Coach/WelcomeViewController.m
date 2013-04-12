#import "WelcomeViewController.h"

@interface WelcomeViewController ()
- (IBAction)getStartedPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *bodyText;

@end

@implementation WelcomeViewController

-(id) init{
    NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
    [exception raise];
    return nil;
}

-(id) initWithDelegate:(id<WelcomeViewControllerDelegate>) delegate{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [super initWithNibName:@"WelcomeViewController_iPhone" bundle:nil];
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
  
}
/*

- (void)customizeSlider
{
     UIImage *stretchLeftTrack = [[UIImage imageNamed:kUnlockBarOnImage] stretchableImageWithLeftCapWidth:51.0 topCapHeight:0.0];
  
     UIImage *stretchRightTrack = [[UIImage imageNamed:kUnlockBarOffImage] stretchableImageWithLeftCapWidth:51.0 topCapHeight:0.0];
   UIImage *newStretchRightTrack = [UIImage addText:stretchRightTrack text:NSLocalizedString(@"SLIDE TO PARTY", nil) textFontSize:18.5 xPos:65 yPos:18.5 colour:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
  
   self.slider.frame = CGRectMake(self.slider.frame.origin.x, self.slider.frame.origin.y, self.slider.frame.size.width, 51);
     [self.slider setThumbImage:[UIImage imageNamed:kUnlockBarHandleImage] forState:UIControlStateNormal];
     [self.slider setThumbImage:[UIImage imageNamed:kUnlockBarHandleImage] forState:UIControlStateHighlighted];
     [self.slider setMinimumTrackImage:stretchLeftTrack forState:UIControlStateNormal];
     [self.slider setMaximumTrackImage:newStretchRightTrack forState:UIControlStateNormal];
}
*/

-(void) cancel{
    
    [self.delegate WelcomeViewControllerDelegate_cancelPressed];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getStartedPressed:(id)sender {
    
    [self.delegate WelcomeViewControllerDelegate_getStartedPressed];
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
