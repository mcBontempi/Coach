#import <UIKit/UIKit.h>

@interface SlotCell : UITableViewCell

@property NSInteger duration;
@property TActivityType activityType;

-(void) setHeight:(CGFloat) height;

@end
