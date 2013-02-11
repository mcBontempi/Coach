#import <Foundation/Foundation.h>

@interface Slot : NSObject
-(id) initWithSlot:(Slot*) slot;
-(id) initWithDuration:(NSInteger) duration startTime:(NSInteger) start activityType:(TActivityType) activityType uid:(NSString *)uid checked:(BOOL) checked;
-(id) initWithDuration:(NSInteger) duration startTime:(NSInteger) start activityType:(TActivityType) activityType;
-(id) initWithDuration:(NSInteger) dureation activityType:(TActivityType) activityType;


- (NSDictionary *) encodeIntoDictionary;

@property NSInteger start;
@property NSInteger duration;
@property TActivityType activityType;
@property (nonatomic, strong) NSString *uid;
@property BOOL checked;

@end
