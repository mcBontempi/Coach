#import "UtilViewController.h"

@interface UtilViewController ()
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
      
      [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                             target:self
                                                                                             action:@selector(makePlanPressed:)] animated:YES];
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

- (IBAction)makePlanPressed:(id)sender {
  
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please name your plan" message:@"keep it short but descriptive" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
  
  alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
  [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if(buttonIndex == 1){
    NSString *text = [alertView textFieldAtIndex:0].text;
    [self.delegate UtilViewControllerDelegate_makeEmptyPlanNamed:text numWeeks:5];
  }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [self.delegate UtilViewControllerDelegate_selectPlan:[self.delegate UtilViewControllerDelegate_getPlanName:indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.delegate UtilViewControllerDelegate_numberOfPlans];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Foobar"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Foobar"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
  }
  cell.textLabel.backgroundColor = [UIColor darkGrayColor];
  cell.textLabel.textColor = [UIColor whiteColor];
  
  cell.contentView.backgroundColor = [UIColor darkGrayColor];
  
  cell.textLabel.text = [self.delegate UtilViewControllerDelegate_getPlanName:indexPath.row];
 
  return cell;
}

@end
