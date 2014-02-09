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

+(NSString *) weekdayFromWeekdayOrdinal:(NSInteger) ordinal{
    return @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"][ordinal];
}


@end
