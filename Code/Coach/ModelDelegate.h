#import <Foundation/Foundation.h>

@protocol ModelDelegate <NSObject>

-(NSData *) getJSON;
-(void) makeTestData;
-(void) save;
-(NSMutableArray*) load;
-(NSArray*) getWeek:(NSInteger) weekIndex;
-(void) setWeek:(NSInteger) weekIndex array:(NSArray*) array;
-(NSMutableArray*) makeCopyOfWeek:(NSArray*) weekToCopy;
-(NSInteger) weekCount;

-(void) ModelDelegate_clearPlan;

@end
