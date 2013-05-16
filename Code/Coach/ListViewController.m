#import "ListViewController.h"
#import <WEPopoverController.h>
#import "TimetablePopoverViewController.h"
#import "Notifications.h"
#import "ListViewCell.h"

@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) WEPopoverController *popover;
@end

@implementation ListViewController

-(id) init
{
  NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
  [exception raise];
  return nil;
}

-(id) initWithDelegate:(id<ListViewControllerDelegate>) delegate
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self = [super initWithNibName:@"ListViewController_iPhone" bundle:nil];
  } else {
    self = [super initWithNibName:@"ListViewController_iPad" bundle:nil];
  }
  if(self) {
    self.delegate = delegate;
    self.navigationItem.title = [self.delegate ListViewControllerDelegate_currentPlan];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slotEditSlotChanged:) name:TTTModelChanged object:nil];
  }
  return self;
}

- (void)slotEditSlotChanged:(NSNotification *)notification
{
  [self.tableView reloadData];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // [self setRightBarButtonEdit];
  [self setLeftBarButtonPlans];
}

-(void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self reloadData];
}

-(void) setRightBarButtonEdit
{
  [self setRightBarButton:UIBarButtonSystemItemEdit];
}

-(void) setLeftBarButtonPlans{
  [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"Timetables" style:UIBarButtonItemStylePlain                                                                                               target:self
                                                                           action:@selector(showPlansBarButtonPressed)] animated:YES];
}

- (WEPopoverContainerViewProperties *)defaultContainerViewProperties
{
	WEPopoverContainerViewProperties *ret = [WEPopoverContainerViewProperties alloc];
	
	CGSize imageSize = CGSizeMake(0.0f, 0.0f);
	NSString *bgImageName = nil;//@"popoverBgWhite.png";
	CGFloat bgMargin = 6.0;
	CGFloat contentMargin = 0.0;
	
	ret.leftBgMargin = bgMargin;
	ret.rightBgMargin = bgMargin;
	ret.topBgMargin = bgMargin;
	ret.bottomBgMargin = bgMargin;
	ret.leftBgCapSize = imageSize.width/2;
	ret.topBgCapSize = imageSize.height/2;
	ret.bgImageName = bgImageName;
	ret.leftContentMargin = contentMargin;
	ret.rightContentMargin = contentMargin;
	ret.topContentMargin = contentMargin;
	ret.bottomContentMargin = contentMargin;
	ret.arrowMargin = 1.0;
	
	ret.upArrowImageName = @"popoverArrowUpSimple.png";
	ret.downArrowImageName = @"popoverArrowDownSimple.png";
	ret.leftArrowImageName = @"popoverArrowLeftSimple.png";
	ret.rightArrowImageName = @"popoverArrowRightSimple.png";
	return ret;
}

- (void) showPlansBarButtonPressed
{
  
  TimetablePopoverViewController *vc = [[TimetablePopoverViewController alloc] initWithDelegate:self];
  
  self.popover = [[WEPopoverController alloc] initWithContentViewController:vc];
  self.popover.containerViewProperties = [self defaultContainerViewProperties];
  [self.popover presentPopoverFromRect:CGRectZero
                                inView:self.view
              permittedArrowDirections:UIPopoverArrowDirectionUp
                              animated:YES];
  
}

-(void) setRightBarButton:(UIBarButtonSystemItem)systemItem
{
  UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 120, 45)];
  [toolbar setBarStyle: UIBarStyleDefault];
  
  NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
  
  [buttons addObject:[[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                      target:nil
                      action:nil]];
  
  [buttons addObject:[[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                      target:nil
                      action:nil]];
  [buttons addObject:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:systemItem
                                                                  target:self
                                                                  action:@selector(toggleEditPressed)]];
  
  // put the buttons in the toolbar and release them
  [toolbar setItems:buttons animated:NO];
  
  
  
  
  self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                          initWithCustomView:toolbar];
}

-(void)toggleEditPressed
{
  [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (void)reloadData
{
  self.navigationItem.title = [self.delegate ListViewControllerDelegate_currentPlan];
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.delegate ListViewControllerDelegate_numberOfWeeks];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  ListViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Foobar"];
  if (cell == nil) {
    cell = [[ListViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Foobar"];
  }
  
  [cell setupWithWeekText:[NSString stringWithFormat:@"%d", indexPath.row+1] weekSummaryText:[self.delegate ListViewControllerDelegate_weekSummary:indexPath.row] weekPercentCompleted:[self.delegate ListViewControllerDelegate_weekPercent:indexPath.row]];
  
  if(indexPath.row == [self.delegate ListViewControllerDelegate_currentWeek]) {
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
  }
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.delegate ListViewControllerDelegate_showWeek:indexPath.row];
}
/*
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
 {
 if(section)
 return 5;
 else return 0;
 }
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 UIView *header =  [[UIView alloc] initWithFrame:CGRectMake(0,0,320,5)];
 
 header.backgroundColor = [UIColor blackColor];
 
 return header;
 }
 */

- (void)ToListViewControllerDelegate_reloadData
{
  [self reloadData];
}

-(NSUInteger) TimetablePopoverViewControllerDelegate_numberOfPlans
{
  return [self.delegate ListViewControllerDelegate_numberOfPlans];
}

-(NSString *) TimetablePopoverViewControllerDelegate_getPlanName:(NSUInteger)index
{
  return [self.delegate ListViewControllerDelegate_getPlanName:index];
}

-(void) TimetablePopoverViewControllerDelegate_showPlan:(NSString*)planName
{
  [self.delegate ListViewControllerDelegate_showPlan:planName];
  
  [self.popover dismissPopoverAnimated:YES];
}

-(void) TimetablePopoverViewControllerDelegate_showPlansInFullscreen
{
  [self.delegate ListViewControllerDelegate_showPlansInFullscreen];
  
  [self.popover dismissPopoverAnimated:YES];
}

- (NSString *)TimetablePopoverViewControllerDelegate_currentPlan
{
  return [self.delegate ListViewControllerDelegate_currentPlan];
}

@end
