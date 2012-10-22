//
//  DataUtil.h
//  Coach
//
//  Created by daren taylor on 26/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtil : NSObject

+(UIColor*) fillUIColorOfActivityType:(TActivityType) activityType;
+(CGColorRef) fillCGColorRefOfActivityType:(TActivityType) activityType;

@end
