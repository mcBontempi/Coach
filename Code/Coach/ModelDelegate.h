#import <Foundation/Foundation.h>

@protocol ModelDelegate <NSObject>

-(NSData *) getJSONForPlan:(NSString *)planName;
-(void) makeTestData;
-(void) save;
-(NSMutableArray*) load;
-(NSArray*) getWeek:(NSInteger) weekIndex;
-(void) setWeek:(NSInteger) weekIndex array:(NSArray*) array;
-(NSMutableArray*) makeCopyOfWeek:(NSArray*) weekToCopy;
-(NSInteger) weekCount;
-(NSUInteger) planCount;
-(NSString *) planName:(NSUInteger) index;
-(void) deletePlan:(NSString *)index;
-(void) ModelDelegate_clearPlan;
-(void) ModelDelegate_makePlanNamed:(NSString *)planName;
-(void) selectPlan:(NSString *)planName;

@end
