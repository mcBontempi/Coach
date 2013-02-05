#import <Foundation/Foundation.h>

@protocol ModelDelegate <NSObject>

-(void) makeTestData;
-(void) save;
-(void) load;
-(NSArray*) getWeek:(NSInteger) weekIndex;
-(void) setWeek:(NSInteger) weekIndex array:(NSArray*) array;
-(NSMutableArray*) makeCopyOfWeek:(NSArray*) weekToCopy;
-(NSInteger) weekCount;

-(void) ModelDelegate_clearPlan;

@end
