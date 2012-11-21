//
//  TypeSelectViewControllerDelegate.h
//  Coach
//
//  Created by Daren Taylor on 27/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol TypeSelectViewControllerDelegate <NSObject>

-(void) TypeSelectViewControllerDelegate_typePressed:(TType) type;

@end
