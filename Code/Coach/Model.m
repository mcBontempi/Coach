#import "Model.h"
#import "Profile.h"
#import "Coach.h"
#import "Slot.h"

@interface Model ()

@property (nonatomic, strong) NSMutableDictionary* plans;
@property (nonatomic, strong) NSString *currentPlanName;

@end

@implementation Model

-(id) init{
  
  if (self = [super init]){

    self.currentPlanName =@"My First Plan";
    
    if(![self load]){
      // first time creation
      self.plans = [[NSMutableDictionary alloc] init];
      
      [self makeTestData];
    }
    
  }
  return self;
}


-(void) makeTestData{
  
  [self clearPlan];
  
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
    [self.plans[self.currentPlanName] addObject: [coach getWeekUsesProfileWithWeek:0]];
  }
}

-(NSArray*) getWeek:(NSInteger) weekIndex{
  NSArray *array = self.plans[self.currentPlanName][weekIndex];
  
  NSLog(@"%@", array.description);
  
  return array;
}

-(void) setWeek:(NSInteger) weekIndex array:(NSArray*) array{
  self.plans[self.currentPlanName][weekIndex] = array;
  
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
  return ((NSArray *)self.plans[self.currentPlanName]).count;
}

-(void) clearPlan{
  self.plans[self.currentPlanName] = [[NSMutableArray alloc] init];
}


-(void) ModelDelegate_makePlanNamed:(NSString *)planName{
  
  [self.plans setObject:[[NSMutableArray alloc] init] forKey:planName];
  
  self.currentPlanName = planName;
  
}


-(NSUInteger)planCount
{
  return self.plans.count;
}

-(NSString *)planName:(NSUInteger) index{
  return [self.plans allKeys][index];
}

-(void) deletePlan:(NSString *) planName{
  [self.plans removeObjectForKey:planName];
}

-(void) ModelDelegate_clearPlan{
  [self clearPlan];
  
}

-(void) selectPlan:(NSString *)planName{
  self.currentPlanName = planName;
}

- (NSMutableArray*)load
{
  NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"plans"];
  if(data){
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(obj){
      self.plans = obj;
    }
  }
  
  return self.plans[self.currentPlanName];
}

- (void) save
{
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.plans];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"plans"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSData *) getJSONForPlan:(NSString *) plan{
  NSMutableArray *jasonableWeeks = [[NSMutableArray alloc] init];
  
  for(NSArray *weekToScan in self.plans[self.currentPlanName]){
    
    NSMutableArray *copiedWeek = [[NSMutableArray alloc] init];
    
    for(NSMutableArray *day in weekToScan ){
      
      NSMutableArray *newDay = [[NSMutableArray alloc] init];
      [copiedWeek addObject:newDay];
      for(Slot* slot in day){
        {
          NSDictionary *slotDict = [slot encodeIntoDictionary];
          [newDay addObject:slotDict];
        }
      }
    }
    
    [jasonableWeeks addObject:copiedWeek];
  }
  
  NSError *error;
  
  return [NSJSONSerialization dataWithJSONObject:jasonableWeeks options:NSJSONWritingPrettyPrinted error:&error];
}

@end
