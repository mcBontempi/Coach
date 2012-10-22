//
//  DurationViewControllerDelegate.h
//  Coach
//
//  Created by Daren Taylor on 27/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol DurationViewControllerDelegate <NSObject>

-(void) DurationViewControllerDelegate_nextPressed:(NSInteger) duration;

@end
