//
//  ProfileLogger.m
//  Coach
//
//  Created by Daren Taylor on 19/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import "ProfileLogger.h"

@implementation ProfileLogger

+(void) logProfile:(Profile *)profile{
    
    DLog(@"-- Profile Start --");
    
    for(NSNumber *number in profile.array){
      DLog(@"%@", number);
    }

    DLog(@"-- Profile End --");
}

@end
