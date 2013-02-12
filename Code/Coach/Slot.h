#import <Foundation/Foundation.h>

@interface Slot : NSObject
-(id) initWithSlot:(Slot*) slot;
-(id) initWithDuration:(NSInteger) duration activityType:(TActivityType) activityType checked:(BOOL) checked;
-(id) initWithDuration:(NSInteger) duration activityType:(TActivityType) activityType;
-(id) initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *) encodeIntoDictionary;

@property NSInteger duration;
@property TActivityType activityType;
@property BOOL checked;

@end
