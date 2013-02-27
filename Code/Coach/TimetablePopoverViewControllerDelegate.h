//
//  TimetablePopoverViewControllerDelegate.h
//  Coach
//
//  Created by daren taylor on 25/02/2013.
//  Copyright (c) 2013 Daren Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimetablePopoverViewControllerDelegate <NSObject>

-(NSUInteger) TimetablePopoverViewControllerDelegate_numberOfPlans;
-(NSString *) TimetablePopoverViewControllerDelegate_getPlanName:(NSUInteger)index;
-(void) TimetablePopoverViewControllerDelegate_showPlan:(NSString*)planName;
-(NSString *)TimetablePopoverViewControllerDelegate_currentPlan;
-(void) TimetablePopoverViewControllerDelegate_showPlansInFullscreen;


@end
