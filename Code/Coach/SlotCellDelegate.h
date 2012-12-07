#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol SlotCellDelegate <NSObject>

-(void) SlotCellDelegate_checked:(BOOL) checked identifier:(id) identifier;

@end
