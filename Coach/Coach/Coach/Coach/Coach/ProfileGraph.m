//
//  ProfileGraph.m
//  Coach
//
//  Created by daren taylor on 20/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import "ProfileGraph.h"
#import "Slot.h"
#import "ProfileLogger.h"

@implementation ProfileGraph

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.5,0.5,0.5,1.0);
	CGContextFillRect(context, rect);
    
    
    // set up the oft used stuff
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    NSInteger colCount = self.profile.array.count;
    
    CGFloat colWidth =  width / colCount;

    CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
	
    [ProfileLogger logProfile:self.profile];
    
    
    NSInteger col = 0;
    for(NSNumber *number in self.profile.array){
        
        NSInteger duration = number.integerValue;
        
        CGFloat barHeight = (height / 100) * duration;
        
        CGContextFillRect(context, CGRectMake(colWidth*col,height - barHeight,colWidth,height  ) );
        
        col++;
    }

}


@end
