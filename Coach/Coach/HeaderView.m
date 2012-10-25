//
//  HeaderView.m
//  Coach
//
//  Created by daren taylor on 24/10/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, strong) UILabel *textLabel1;
@property (nonatomic, strong) UILabel *textLabel2;
@property (nonatomic, strong) UILabel *currentLabel;


@end

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,40)];
        [self addSubview:self.textLabel1];
 
        self.textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,40)];
        [self addSubview:self.textLabel2];
        
        
        self.currentLabel = self.textLabel1;
        
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        
        self.textLabel1.backgroundColor = [UIColor clearColor];
        self.textLabel2.backgroundColor = [UIColor clearColor];
        
        self.textLabel1.textColor = [UIColor blackColor];
        self.textLabel2.textColor = [UIColor blackColor];
        
    
    }
    return self;
}

-(void) animateIn:(UILabel *) label{
    
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 1.0;
        CGRect frame = label.frame;
     //   frame.origin.y = 0;
        label.frame = frame;
    }];
}
-(void) animateOut:(UILabel *) label{
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 0.0;
        CGRect frame = label.frame;
        //   frame.origin.y = -100;
        label.frame = frame;
    }];



}



-(void) setText:(NSString *) text{
    
    if(self.warning) self.backgroundColor = [UIColor redColor];
    else self.backgroundColor = [UIColor whiteColor];
    
    
    if(self.currentLabel == self.textLabel1){
        [self animateOut:self.textLabel1];
        self.textLabel2.text = text;
        [self animateIn:self.textLabel2];
        
        self.currentLabel = self.textLabel2;
    }
    else{
        [self animateOut:self.textLabel2];
        self.textLabel1.text = text;
        [self animateIn:self.textLabel1];

        self.currentLabel = self.textLabel1;

    }
}

@end
