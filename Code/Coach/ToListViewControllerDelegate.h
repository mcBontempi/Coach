#import <Foundation/Foundation.h>

@protocol ToListViewControllerDelegate <NSObject>

-(void) ToListViewControllerDelegate_highlightCurrentWeek:(NSInteger) weekIndex;

-(void)ToListViewControllerDelegate_reloadData;

@end
