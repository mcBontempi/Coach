#import <Foundation/Foundation.h>

@protocol UtilViewControllerDelegate <NSObject>

-(void) UtilViewControllerDelegate_exportPlan:(NSString *)planName;
-(void) UtilViewControllerDelegate_selectPlan:(NSString *)planName;
-(void) UtilViewControllerDelegate_showPlan:(NSString *)planName;
-(void) UtilViewControllerDelegate_cancel;
-(void) UtilViewControllerDelegate_makeEmptyPlanNamed:(NSString *)text numWeeks:(NSUInteger)numWeeks;
-(NSUInteger) UtilViewControllerDelegate_numberOfPlans;
-(NSString *) UtilViewControllerDelegate_getPlanName:(NSUInteger)index;
-(void) UtilViewControllerDelegate_deletePlan:(NSString *)planName;

@end
