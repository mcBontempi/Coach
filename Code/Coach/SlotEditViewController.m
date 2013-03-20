#import "SlotEditViewController.h"

@implementation SlotEditViewController{
  
  __weak id<SlotEditViewControllerDelegate> _delegate;
}

-(id) initWithDelegate:(id<SlotEditViewControllerDelegate>) delegate
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self = [super initWithNibName:@"SlotEditViewController_iPhone" bundle:nil];
  } else {
    self = [super initWithNibName:@"SlotEditViewController_iPad" bundle:nil];
  }
  if(self){
    _delegate = delegate;
  }
  
  return self;
}



@end
