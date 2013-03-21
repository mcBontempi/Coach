#import <Foundation/Foundation.h>

@interface Slot : NSObject
-(id) initWithSlot:(Slot*) slot;
-(id) initWithDuration:(NSInteger) duration activityType:(TActivityType) activityType checked:(BOOL) checked tags:(NSString *)tags athleteNotes:(NSString *)athleteNotes coachNotes:(NSString *)coachNotes;
-(id) initWithDuration:(NSInteger) duration activityType:(TActivityType) activityType;
-(id) initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *) encodeIntoDictionary;

@property NSInteger duration;
@property TActivityType activityType;
@property BOOL checked;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *athleteNotes;
@property (nonatomic, strong) NSString *coachNotes;

@end
