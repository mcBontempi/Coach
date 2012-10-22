//
//  Slot.h
//  Coach
//
//  Created by Daren Taylor on 18/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Slot : NSObject

-(id) initWithDuration:(NSInteger) duration startTime:(NSInteger) start activityType:(TActivityType) activityType;
-(id) initWithDuration:(NSInteger) dureation activityType:(TActivityType) activityType;

@property NSInteger start;
@property NSInteger duration;
@property TActivityType activityType;

@end
