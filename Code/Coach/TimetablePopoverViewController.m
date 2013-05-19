#import "TimetablePopoverViewController.h"
#import "TimetablePopoverViewControllerDelegate.h"
#import "UtilTableViewCell.h"

const CGFloat popoverWidth = 240;

@interface TimetablePopoverViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,weak) id<TimetablePopoverViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UINavigationBar *bottomNavigationBar;
- (IBAction)showInFullscreen:(id)sender;
@end

@implementation TimetablePopoverViewController

-(id) initWithDelegate:(id<TimetablePopoverViewControllerDelegate>) delegate{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self = [super initWithNibName:@"TimetablePopoverViewController_iPhone" bundle:nil];
  } else {
    self = [super initWithNibName:@"TimetablePopoverViewController_iPad" bundle:nil];
  }
  if(self){
    _delegate = delegate;
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.bottomNavigationBar.shadowImage = [[UIImage alloc] init];
  /*
  self.view.backgroundColor = [UIColor clearColor];
  
  self.bottomNavigationBar.shadowImage = [[UIImage alloc] init];
  self.bottomNavigationBar.backgroundColor = [UIColor clearColor];
  self.bottomNavigationBar.tintColor = [UIColor clearColor];
  self.bottomNavigationBar.b
  //self.bottomNavigationBar.
  
  
  
  self.bottomNavigationBar.translucent = YES;
  self.bottomNavigationBar.opaque = YES;
 // self.navigationController.navigationBar.tintColor = [UIColor clearColor];
 // self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
   
   */
  
}

- (CGSize) contentSizeForViewInPopover{
  
  NSUInteger numCells = [self.delegate TimetablePopoverViewControllerDelegate_numberOfPlans];
  
  return CGSizeMake(popoverWidth, 40 + (numCells*44));
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return [_delegate TimetablePopoverViewControllerDelegate_numberOfPlans];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UtilTableViewCell *cell = (UtilTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Timetable"];
  if (cell == nil) {
    cell = [[UtilTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Timetable"];
  }
  
  NSString *thisRowPlanName = [self.delegate TimetablePopoverViewControllerDelegate_getPlanName:indexPath.row];
  
  cell.textLabel.text = thisRowPlanName;
  
  NSString *currentPlan = [self.delegate TimetablePopoverViewControllerDelegate_currentPlan];
  
  if([thisRowPlanName isEqualToString:currentPlan]){
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
  }
  else{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  }
  
  cell.contentView.backgroundColor = [UIColor clearColor];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [_delegate TimetablePopoverViewControllerDelegate_showPlan:[_delegate TimetablePopoverViewControllerDelegate_getPlanName:indexPath.row]];
}



- (IBAction)showInFullscreen:(id)sender {
  [_delegate TimetablePopoverViewControllerDelegate_showPlansInFullscreen];
  
}
- (void)viewDidUnload {
  [self setBottomNavigationBar:nil];
  [super viewDidUnload];
}
@end
