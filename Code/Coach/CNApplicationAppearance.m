//
//  CNApplicationAppearance.m
//  CAN
//
//  Created by Luke Redpath on 08/02/2013.
//  Copyright (c) 2013 LShift. All rights reserved.
//

#import "CNApplicationAppearance.h"

@implementation CNApplicationAppearance

+ (void)installApplicationAppearance
{
  [self customiseNavigationBars];
}

+ (void)customiseNavigationBars
{
  if ([[UINavigationBar class] respondsToSelector:@selector(appearance)]) {
    
    if ([[UINavigationBar appearance] respondsToSelector:@selector(setBarTintColor:)]) {
      [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    }
  }
}
@end
