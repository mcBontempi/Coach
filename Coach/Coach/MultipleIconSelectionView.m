#import "MultipleIconSelectionView.h"

@interface MultipleIconSelectionView ()


@property (nonatomic, strong) NSArray *images;
@property CGSize iconSize;
@property NSInteger padding;

@property (nonatomic, weak) id<MultipleIconSelectionViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *selectedIndexesArray;

@end


@implementation MultipleIconSelectionView

- (id)initWithPoint:(CGPoint)point images:(NSArray*) images iconSize:(CGSize) iconSize padding:(NSInteger) padding delegate:(id<MultipleIconSelectionViewDelegate>) delegate
{
    self = [super initWithFrame:CGRectMake(point.x, point.y, 0,0)];
    if (self) {
        self.images = images;
        self.iconSize = iconSize;
        self.padding = padding;
        self.delegate = delegate;
        
        self.selectedIndexesArray = [[NSMutableArray alloc] init];
     
    }
    return self;
}

-(void) setupWithSelectedIndexes:(NSMutableArray *) selectedIndexesArray{
    
    self.selectedIndexesArray = selectedIndexesArray;
    
    for (UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    
    CGFloat x = 0;
    
    NSInteger index = 0;
    
    for(UIImage *image in self.images){
        
        x+=self.padding;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x,self.padding, self.iconSize.width, self.iconSize.height)];
        button.tag = index;
        
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
       
        [button setImage:image forState:UIControlStateNormal ];
        
        x+=self.iconSize.width;
        
        [self addSubview:button];
        
        
        
        
        if([self index:index existsInArray:selectedIndexesArray]){
            button.alpha = 1.0;
        }
        else{
            button.alpha = 0.5;
        }
        
        
        index++;
    }
    
    CGRect frame = self.frame;
    
    // we set the actual size here, theres no point setting it from the initializer
    // as we dont know the final size.
    frame.size = CGSizeMake(x+self.padding, self.padding*2 + self.iconSize.height);
    
    self.frame = frame;

    
}

-(NSNumber*) index:(NSInteger) index existsInArray:(NSArray*) selectedIndexesArray{
    for(NSNumber *number in selectedIndexesArray){
        if(number.integerValue == index)
            return number;
    }
    return NO;
}

- (void) itemPressed:(UIControl *)sender{
    
    NSInteger index = sender.tag;
    
    NSNumber *selectedNumber = [self index:index existsInArray:self.selectedIndexesArray];
    
    if(selectedNumber){
        [self.selectedIndexesArray removeObject:selectedNumber];
    }
    else{
        [self.selectedIndexesArray addObject:@(index)];
    }
    
    [self setupWithSelectedIndexes:self.selectedIndexesArray];
    
    [self.delegate MultipleIconSelectionViewDelegate_iconsSelected:nil];
}






@end
