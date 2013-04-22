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
  if ([[UINavigationBar class] respondsToSelector:@selector(appearance)])
  {
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], UITextAttributeTextColor,
                                                          [UIColor blackColor], UITextAttributeTextShadowColor,
                                                          [NSValue valueWithUIOffset:UIOffsetMake(1, 0)], UITextAttributeTextShadowOffset,
                                                          [UIFont boldSystemFontOfSize:15.0], UITextAttributeFont,
                                                          nil]];
  }
}

@end
