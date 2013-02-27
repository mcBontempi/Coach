#import "TimetablePopoverViewController.h"
#import "TimetablePopoverViewControllerDelegate.h"

const CGFloat popoverWidth = 200;

@interface TimetablePopoverViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,weak) id<TimetablePopoverViewControllerDelegate> delegate;
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
  
  self.view.backgroundColor = [UIColor whiteColor];
}

- (CGSize) contentSizeForViewInPopover{
  
  NSUInteger numCells = [self.delegate TimetablePopoverViewControllerDelegate_numberOfPlans];
  
  return CGSizeMake(popoverWidth, 62 + (numCells*44));
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return [_delegate TimetablePopoverViewControllerDelegate_numberOfPlans];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Timetable"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Timetable"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
 
  cell.textLabel.textColor = [UIColor whiteColor];
  
  cell.backgroundColor = [UIColor darkGrayColor];
  
  NSString *thisRowPlanName = [self.delegate TimetablePopoverViewControllerDelegate_getPlanName:indexPath.row];
  
  cell.textLabel.text = thisRowPlanName;
  
  
  NSString *currentPlan = [self.delegate TimetablePopoverViewControllerDelegate_currentPlan];
  
  if([thisRowPlanName isEqualToString:currentPlan]){
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
  }
  else{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  }
  
  
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [_delegate TimetablePopoverViewControllerDelegate_showPlan:[_delegate TimetablePopoverViewControllerDelegate_getPlanName:indexPath.row]];
}



- (IBAction)showInFullscreen:(id)sender {
  [_delegate TimetablePopoverViewControllerDelegate_showPlansInFullscreen];
  
}
@end
