#import <Foundation/Foundation.h>

@protocol UtilViewControllerDelegate <NSObject>

-(void) UtilViewControllerDelegate_export;
-(void) UtilViewControllerDelegate_cancel;
-(void) UtilViewControllerDelegate_makeEmptyPlan:(NSInteger)numWeeks;

@end
