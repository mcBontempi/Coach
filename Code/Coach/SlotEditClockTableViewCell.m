//
//  SlotEditClockTableViewCell.m
//  Coach
//
//  Created by daren taylor on 23/05/2013.
//  Copyright (c) 2013 Daren Taylor. All rights reserved.
//

#import "SlotEditClockTableViewCell.h"
#import "PSAnalogClockView.h"
#import "KTOneFingerRotationGestureRecognizer.h"


@implementation SlotEditClockTableViewCell {
  PSAnalogClockView *_analogClockView;
  
  CGFloat _duration;
}

- (void)awakeFromNib
{
  [self setupClock];
}

- (CGFloat) degreesToRadians:(CGFloat) degrees
{
  return degrees * M_PI / 180;
}

- (CGFloat) radiansToDegrees:(CGFloat) radians
{
  return radians * 180 / M_PI;
}

- (void)rotating:(KTOneFingerRotationGestureRecognizer *)recognizer
{
  CGFloat rotation =  [recognizer rotation];
  
  CGFloat degrees = [self radiansToDegrees:rotation];
  
  if (degrees > 300) degrees-=360;
  
  if (degrees < -300) degrees+=360;
  
  (_duration+= (degrees/6)) ;
  
  _analogClockView.totalMinutes = _duration;
}


- (void)setupClock
{
  _analogClockView = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(170,30,100,100)];
  _analogClockView.clockFaceImage  = [UIImage imageNamed:@"ClockFace"];
  _analogClockView.hourHandImage   = [UIImage imageNamed:@"clock_hour_hand"];
  _analogClockView.minuteHandImage = [UIImage imageNamed:@"clock_minute_hand"];
  // _analogClockView.secondHandImage = [UIImage imageNamed:@"clock_second_hand"];
  _analogClockView.centerCapImage  = [UIImage imageNamed:@"clock_centre_point"];
  [self.contentView addSubview:_analogClockView];
  
  
  KTOneFingerRotationGestureRecognizer *rotation = [[KTOneFingerRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotating:)];
  [_analogClockView addGestureRecognizer:rotation];
  
  // [self.clockView start];
  
  
  [_analogClockView start];
}


@end
