#import "TimetablePopoverViewController.h"
#import "TimetablePopoverViewControllerDelegate.h"

const CGSize popoverSize = {200,200};

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

- (CGSize) contentSizeForViewInPopover{
  
  return popoverSize;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return [_delegate TimetablePopoverViewControllerDelegate_numberOfPlans];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Timetable"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Timetable"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
  }
 
  cell.textLabel.text = [_delegate TimetablePopoverViewControllerDelegate_getPlanName:indexPath.row];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [_delegate TimetablePopoverViewControllerDelegate_showPlan:[_delegate TimetablePopoverViewControllerDelegate_getPlanName:indexPath.row]];
}



- (IBAction)showInFullscreen:(id)sender {
  [_delegate TimetablePopoverViewControllerDelegate_showPlansInFullscreen];
  
}
@end
