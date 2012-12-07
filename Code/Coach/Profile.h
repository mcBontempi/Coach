//
//  Profile.h
//  Coach
//
//  Created by Daren Taylor on 19/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Profile : NSObject

@property NSInteger numberOfWeeks;
@property NSInteger startPercentage;
@property NSInteger taper;
// Number of weeks between rest week
@property NSInteger frequency;
@property NSInteger frequencyStrength;

@property NSArray *array;

-(void) generate;



@end
