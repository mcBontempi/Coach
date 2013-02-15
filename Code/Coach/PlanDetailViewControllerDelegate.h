#import <Foundation/Foundation.h>

@protocol PlanDetailViewControllerDelegate <NSObject>

-(void) PlanDetailViewControllerDelegate_exportPlan;
-(NSString *) PlanDetailViewControllerDelegate_planName;
-(void) PlanDetailViewControllerDelegate_deletePlan;

@end
