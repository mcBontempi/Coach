#import <Foundation/Foundation.h>

@interface PagingScrollView : UIScrollView
{
    UIEdgeInsets responseInsets;
}

@property (nonatomic, assign) UIEdgeInsets responseInsets;

@end