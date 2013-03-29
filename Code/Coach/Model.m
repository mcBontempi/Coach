#import "Model.h"
#import "Profile.h"
#import "Coach.h"
#import "Slot.h"

@interface Model ()

@property (nonatomic, strong) NSMutableDictionary* plans;


@end

@implementation Model

-(id) init{
  
  if (self = [super init]){
    
    _currentPlan = @"";
    
    if(![self load]){
      // first time creation
      self.plans = [[NSMutableDictionary alloc] init];
      
    }
    
  }
  return self;
}


-(void) makeTestData{
  
  [self clearPlan];
  
  Coach *coach = [[Coach alloc] init];
  
  // test data
  const NSInteger length = 10;
  
  Profile *profile = [[Profile alloc] init];
  profile.numberOfWeeks = length;
  profile.startPercentage =00;
  [profile generate];
  
  coach.profile = profile;
  coach.peakMinutes = 20*60;
  
  for(NSInteger week = 0 ; week <= length ; week++){
      [self.plans[self.currentPlan] addObject:[coach getWeekUsesProfileWithWeek:0]];
  }
}

-(NSArray*) getWeek:(NSInteger) weekIndex{
  NSArray *array = self.plans[self.currentPlan][weekIndex];
  
  NSLog(@"%@", array.description);
  
  return array;
}

-(void) setWeek:(NSInteger) weekIndex array:(NSArray*) array{
  self.plans[self.currentPlan][weekIndex] = array;
  
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
  return ((NSArray *)self.plans[self.currentPlan]).count;
}

-(void) clearPlan{
  self.plans[self.currentPlan] = [[NSMutableArray alloc] init];
  [self save];
}

-(void) makePlanNamed:(NSString *)planName{
  [self.plans setObject:[[NSMutableArray alloc] init] forKey:planName];
  _currentPlan = planName;
  [self save];
}

-(void) addPlan:(NSMutableArray *)plan named:(NSString *)planName{
  [self.plans setObject:plan forKey:planName];
  _currentPlan = planName;
  [self save];
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
  _currentPlan = @"";
  [self save];
}

-(void) selectPlan:(NSString *)planName{
  _currentPlan = planName;
  [self save];
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
  
  return self.plans[self.currentPlan];
}

- (void) save
{
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.plans];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"plans"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSData *) getJSONForPlan:(NSString *) plan{
  NSMutableArray *jasonableWeeks = [[NSMutableArray alloc] init];
  
  for(NSArray *weekToScan in self.plans[self.currentPlan]){
    
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

- (void) createPlanFromJSONDataAndMakeCurrent:(NSData *)jsonData{
  NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
  
  NSLog(@"%@", jsonString);
  
  NSError *error;
  NSMutableArray *planToScan = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error ];
  
  
  
  NSMutableArray *copiedPlan = [[NSMutableArray alloc] init];
  
  for(NSArray *weekToScan in planToScan){
    
    
    
    NSMutableArray *copiedWeek = [[NSMutableArray alloc] init];
    
    for(NSMutableArray *day in weekToScan ){
      
      NSMutableArray *newDay = [[NSMutableArray alloc] init];
      [copiedWeek addObject:newDay];
      for(NSDictionary *dict in day){
        {
          Slot *slot = [[Slot alloc] initWithDictionary:dict];
          [newDay addObject:slot];
        }
      }
    }
    
    [copiedPlan addObject:copiedWeek];
  }
  
  
  
  
  [self addPlan:copiedPlan named:@"Imported"];
}


@end
