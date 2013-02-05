#import "Model.h"
#import "Profile.h"
#import "Coach.h"
#import "Slot.h"

@interface Model ()

@property (nonatomic, strong) NSMutableArray* weeks;

@end

@implementation Model

-(id) init{
    if (self = [super init]){
        [self clearPlan];
    }
    return self;
}


-(void) makeTestData{
    
    Coach *coach = [[Coach alloc] init];
    
    // test data
    const NSInteger length = 45;
    
    Profile *profile = [[Profile alloc] init];
    profile.numberOfWeeks = length;
    profile.startPercentage =30;
    [profile generate];
    
    coach.profile = profile;
    coach.peakMinutes = 20*60;
    
    for(NSInteger week = 0 ; week <= length ; week++){
        [self.weeks addObject: [coach getWeekUsesProfileWithWeek:0]];
    }
}

-(NSArray*) getWeek:(NSInteger) weekIndex{
    NSArray *array = self.weeks[weekIndex];
    
    NSLog(@"%@", array.description);
    
    return self.weeks[weekIndex];
}

-(void) setWeek:(NSInteger) weekIndex array:(NSArray*) array{
    self.weeks[weekIndex] = array;
  
  [self save];
}

-(NSMutableArray*) makeCopyOfWeek:(NSArray*) weekToCopy{
    
    NSMutableArray *copiedWeek = [[NSMutableArray alloc] init];
    
    for(NSMutableArray *day in weekToCopy ){
        
        NSMutableArray *newDay = [[NSMutableArray alloc] init];
        [copiedWeek addObject:newDay];
        for(Slot* slot in day){
            {
                Slot *newSlot = [[Slot alloc] initWithSlot:slot];
                [newDay addObject:newSlot];
            }
        }
    }
    return copiedWeek;
}

-(NSInteger) weekCount{
    return self.weeks.count;
}

-(void) clearPlan{
    self.weeks = [[NSMutableArray alloc] init];
}

-(void) ModelDelegate_clearPlan{
    [self clearPlan];
    
}

- (void)load
{
  
  NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"plan"];
  if(data){
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(obj){
      self.weeks = obj;
    }
  }
}

- (void) save
{
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.weeks];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"plan"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}








@end
