#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, strong) UILabel *textLabel1;
@property (nonatomic, strong) UILabel *textLabel2;
@property (nonatomic, strong) UILabel *currentLabel;
@property (nonatomic, strong) UIImageView *warningImageView;

@end

const CGFloat paddingForWarning = 5;

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        [self addSubview:self.textLabel1];
        
        self.textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        [self addSubview:self.textLabel2];
        
        self.currentLabel = self.textLabel1;
        
        self.textLabel1.backgroundColor = [UIColor clearColor];
        self.textLabel2.backgroundColor = [UIColor clearColor];
        
        self.textLabel1.textColor = [UIColor whiteColor];
        self.textLabel2.textColor = [UIColor whiteColor];
        
        self.warningImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noEntry.png"]];
        self.warningImageView.frame = CGRectMake(frame.size.width - frame.size.height +paddingForWarning ,paddingForWarning,self.frame.size.height - (paddingForWarning*2),self.frame.size.height - (paddingForWarning*2) );
         
        [self addSubview:self.warningImageView];
    }
    return self;
}

-(void) animateIn:(UILabel *) label{
    
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 1.0;
        CGRect frame = label.frame;
        label.frame = frame;
    }];
}
-(void) animateOut:(UILabel *) label{
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 0.0;
        CGRect frame = label.frame;
        label.frame = frame;
    }];
}

-(void) setText:(NSString *) text{
    if(![text isEqualToString:self.currentLabel.text]){
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
}

-(void) setWarning:(BOOL) warning{
    [UIView animateWithDuration:0.1 animations:^{
        
        if(warning){
            CGRect frame = self.warningImageView.frame;
            frame.origin.x = self.frame.size.width - self.frame.size.height +paddingForWarning;
            self.warningImageView.frame = frame;
            self.warningImageView.alpha = 1.0;
            
        }
        else {
            CGRect frame = self.warningImageView.frame;
            frame.origin.x = self.frame.size.width;
            self.warningImageView.frame = frame;
            self.warningImageView.alpha = 0.0;
        }
    }];
}

@end
