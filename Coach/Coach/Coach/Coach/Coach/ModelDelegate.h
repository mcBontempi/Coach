#import <Foundation/Foundation.h>

@protocol ModelDelegate <NSObject>

-(void) makeTestData;
-(NSArray*) getWeek:(NSInteger) weekIndex;
-(void) setWeek:(NSInteger) weekIndex array:(NSArray*) array;
-(NSMutableArray*) makeCopyOfWeek:(NSArray*) weekToCopy;
-(NSInteger) weekCount;

@end
