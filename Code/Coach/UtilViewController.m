#import "UtilViewController.h"

@interface UtilViewController ()
- (IBAction)makePlanPressed:(id)sender;

- (IBAction)toggleEditPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

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

- (void) UtilViewControllerProtocol_reloadData{
  [self.tableView reloadData];
}

- (IBAction)makePlanPressed:(id)sender {
  
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please name your plan" message:@"keep it short but descriptive" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
  
  alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
  [alertView show];
}

- (IBAction)toggleEditPressed:(id)sender {
  
  [self.tableView setEditing:!self.tableView.editing animated:YES];
  
  if(self.tableView.editing){
    
    self.editButton.title = @"Done";
  
  }
  else{
    self.editButton. title = @"Edit";
    
  }

}

- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  
  // to show currectly selected cell.
  [self.tableView reloadData];
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
  [self.delegate UtilViewControllerDelegate_showPlan:[self.delegate UtilViewControllerDelegate_getPlanName:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
  [self.delegate UtilViewControllerDelegate_exportPlan:[self.delegate UtilViewControllerDelegate_getPlanName:indexPath.row]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.delegate UtilViewControllerDelegate_numberOfPlans];
}

- (void)checkButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.tableView];
  
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
	if (indexPath != nil)
	{
		[self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Foobar"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Foobar"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    UIImage *image = [UIImage imageNamed:@"export.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, 32, 32);
    button.frame = frame;	// match the button's size with the image size
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    // set the button's target to this table view controller so we can interpret touch events and map that to a NSIndexSet
    [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.accessoryView = button;
    
  }
//  cell.textLabel.backgroundColor = [UIColor darkGrayColor];
  cell.textLabel.textColor = [UIColor whiteColor];
  
  cell.backgroundColor = [UIColor darkGrayColor];
  
  NSString *thisRowPlanName = [self.delegate UtilViewControllerDelegate_getPlanName:indexPath.row];
  
  cell.textLabel.text = thisRowPlanName;
 
    NSString *currentPlan = [self.delegate UtilViewControllerDelegate_currentPlan];
  
  if([thisRowPlanName isEqualToString:currentPlan]){
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
  }
  else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
  }
  
  
  return cell;
}


- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self.tableView beginUpdates];
    NSMutableArray *deleteArray = [[NSMutableArray alloc] init];
    [deleteArray addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    [self.tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationLeft];
    [self.delegate UtilViewControllerDelegate_deletePlan:[self.delegate UtilViewControllerDelegate_getPlanName:indexPath.row]];
    [self.tableView endUpdates];
  }
}



- (void)viewDidUnload {
  [self setEditButton:nil];
  [super viewDidUnload];
}
@end
