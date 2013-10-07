#import "UtilViewController.h"
#import "UtilTableViewCell.h"

@interface UtilViewController ()
- (IBAction)makePlanPressed:(id)sender;

- (IBAction)toggleEditPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *myNavigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end

@implementation UtilViewController

-(id) init{
  NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
  [exception raise];
  return nil;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
}

- (BOOL)prefersStatusBarHidden
{
  return YES;
}

- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  
  self.myNavigationBar.topItem.title = @"Manage Timetables";
  
  //  self.myNavigationBar.topItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"triathlonTimetableJustTitle.png"]];
  
  // to show currectly selected cell.
  [self.tableView reloadData];
  
  self.tableView.userInteractionEnabled = YES;
  
  [self hideEditButtonIfNoData];
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

- (void)hideEditButtonIfNoData
{
  if(![self.tableView numberOfRowsInSection:0])
  {
    self.editButton.enabled = NO;
  }

}

- (void) UtilViewControllerProtocol_reloadData{
  [self.tableView reloadData];
  [self hideEditButtonIfNoData];
   
}

- (IBAction)makePlanPressed:(id)sender {
  
  [self.delegate UtilViewControllerDelegate_askUserForNewPlanDetails];
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

- (IBAction)getTimetablesPressed:(id)sender {
    NSString* launchUrl =@"http://www.triathlontimetable.com";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
  return YES;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  [self.delegate UtilViewControllerDelegate_selectPlan:[self.delegate UtilViewControllerDelegate_getPlanName:indexPath.row]];
  [self.tableView reloadData];
 
  self.tableView.userInteractionEnabled = NO;
  
  [self performSelector:@selector(doSelection:) withObject:indexPath afterDelay:0.1];
}

- (void)doSelection:(NSIndexPath *)indexPath
{
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
  UtilTableViewCell *cell = (UtilTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"Foobar"];
  if (cell == nil) {
    cell = [[UtilTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Foobar"];
 
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

  }
  
  
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


@end
