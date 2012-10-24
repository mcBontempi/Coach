#import "TimetableViewAgent.h"
#import "Slot.h"

@interface TimetableViewAgent ()

@property (nonatomic, strong) Model *model;
@property (nonatomic, weak) id<TimetableViewAgentDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *week;

@end

@implementation TimetableViewAgent

-(id) initWithModel:(Model *) model delegate:(id<TimetableViewAgentDelegate>) delegate{
    self = [super init];
    if(self) {
        self.model = model;
        self.delegate = delegate;
    }
    return self;
}

-(NSArray *) currentWeek{
    if(!self.week) {
        
        self.week = self.model.weeks[0];
        
        for(NSMutableArray *array in self.week){
            
            if(!array.count){
                [array addObject:[[Slot alloc] initWithDuration:0 activityType:EActivityTypeStrengthAndConditioning ]];
            }
        }
        
    }return self.week;
}


-(void) moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    Slot *slot = self.week[sourceIndexPath.section][sourceIndexPath.row];
    
    NSMutableArray *day = self.week[sourceIndexPath.section];
    
    [day removeObjectAtIndex:sourceIndexPath.row];
    
    day = self.week[destinationIndexPath.section];
    
    [day insertObject:slot atIndex:destinationIndexPath.row];
    
    [self checkForEmptyDaysAndInsertRestDaysIfRequired];
}

-(void) checkForEmptyDaysAndInsertRestDaysIfRequired{
    
    NSInteger day = 0;
    
    for(NSMutableArray *array in self.week){
        
        if(!array.count){
            [array addObject:[[Slot alloc] initWithDuration:0 activityType:EActivityTypeStrengthAndConditioning ]];
         //   [self.toViewDelegate insertRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:day]];
        
        
           [self.toViewDelegate reloadTable];
        }
        
        else if(array.count >1){
            NSInteger deleteIndex = 0;
            BOOL delete = NO;
            
            Slot *slot;
            
            for(slot in array){
                if(slot.activityType == EActivityTypeStrengthAndConditioning){
                    
                    delete = YES;
                    break;
                }
                deleteIndex++;
            }
        
            if(delete){
                [array removeObject:slot];
            
                DLog(@"row = %d section = %d", deleteIndex, day)
                
           //     [self.toViewDelegate removeRowAtIndexPath:[NSIndexPath indexPathForRow:deleteIndex inSection:day]];
            
                [self.toViewDelegate reloadTable];
            
            
            }
        }
        
        
        day++;
    }
}

@end
