#import "ListViewController.h"
#import <WEPopoverController.h>
#import "TimetablePopoverViewController.h"

@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) WEPopoverController *popover;
@end


@protocol CHStaticDemoDelegate <NSObject>

// method to inform slidecontroller that something has been selected
-(void)staticDemoDidSelectText:(NSString *)text;

@end


@implementation ListViewController

-(id) init{
  NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
  [exception raise];
  return nil;
}

-(id) initWithDelegate:(id<ListViewControllerDelegate>) delegate{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self = [super initWithNibName:@"ListViewController_iPhone" bundle:nil];
  } else {
    self = [super initWithNibName:@"ListViewController_iPad" bundle:nil];
  }
  if(self){
    self.delegate = delegate;
    
    self.navigationItem.title = [self.delegate ListViewControllerDelegate_currentPlan];
  }
  
  return self;
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

-(void) setRightBarButtonEdit{
  [self setRightBarButton:UIBarButtonSystemItemEdit];
}



-(void) setLeftBarButtonPlans{
  [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"Timetables" style:UIBarButtonItemStylePlain                                                                                               target:self
                                                                           action:@selector(showPlansBarButtonPressed)] animated:YES];
}

- (void) showPlansBarButtonPressed{
  
  TimetablePopoverViewController *vc = [[TimetablePopoverViewController alloc] initWithDelegate:self];
  
  
 // UIViewController *vc = [[UIViewController alloc] init];
  
  self.popover = [[WEPopoverController alloc] initWithContentViewController:vc];
  [self.popover presentPopoverFromRect:CGRectZero
                                          inView:self.view
                        permittedArrowDirections:UIPopoverArrowDirectionUp
                                        animated:YES];

  
}

-(void) setRightBarButton:(UIBarButtonSystemItem)systemItem {
  
  
  
  UIToolbar* toolbar = [[UIToolbar alloc]
                        initWithFrame:CGRectMake(0, 0, 120, 45)];
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




-(void)toggleEditPressed{
  [self.tableView setEditing:!self.tableView.editing animated:YES];
  
  if(self.tableView.editing){
     }
  else{
       
  }
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.delegate ListViewControllerDelegate_numberOfWeeks];
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
  
  cell.textLabel.text = [NSString stringWithFormat:@"Week %d", indexPath.row];
  return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [self.delegate ListViewControllerDelegate_showWeek:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  if(section)
    return 5;
  else return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  UIView *header =  [[UIView alloc] initWithFrame:CGRectMake(0,0,320,5)];
  
  header.backgroundColor = [UIColor blackColor];
  
  return header;
}

-(void) ToListViewControllerDelegate_highlightCurrentWeek:(NSInteger) weekIndex{
  //   [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:weekIndex inSection:1] animated:YES scrollPosition:UITableViewScrollPositionTop];
}


- (void)ToListViewControllerDelegate_reloadData{
  [self reloadData];
}


-(NSUInteger) TimetablePopoverViewControllerDelegate_numberOfPlans{
  return [self.delegate ListViewControllerDelegate_numberOfPlans];
}
-(NSString *) TimetablePopoverViewControllerDelegate_getPlanName:(NSUInteger)index{
  return [self.delegate ListViewControllerDelegate_getPlanName:index];
}

-(void) TimetablePopoverViewControllerDelegate_showPlan:(NSString*)planName{
  [self.delegate ListViewControllerDelegate_showPlan:planName];
  
  [self.popover dismissPopoverAnimated:YES];
}

-(void) TimetablePopoverViewControllerDelegate_showPlansInFullscreen{
  [self.delegate ListViewControllerDelegate_showPlansInFullscreen];
  
    [self.popover dismissPopoverAnimated:YES];
}


@end
