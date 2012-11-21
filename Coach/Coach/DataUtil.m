//
//  DataUtil.m
//  Coach
//
//  Created by daren taylor on 26/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import "DataUtil.h"
#import "Constants.h"

@implementation DataUtil

+(UIColor*) fillUIColorOfActivityType:(TActivityType) activityType{
    
    switch(activityType){
        case EActivityTypeBike:
            return [UIColor greenColor];
        case EActivityTypeBrick:
            return [UIColor purpleColor];
        case EActivityTypeRun:
            return [UIColor redColor];
        case EActivityTypeSwim:
            return [UIColor blueColor];
        case EActivityTypeStrengthAndConditioning:
            return [UIColor grayColor];
    }
}

+(CGColorRef) fillCGColorRefOfActivityType:(TActivityType) activityType{
    return [self fillUIColorOfActivityType:activityType].CGColor;
}

+(NSString *) weekdayFromWeekdayOrdinal:(NSInteger) ordinal{
    return @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"][ordinal];
}


@end
