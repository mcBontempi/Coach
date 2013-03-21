#import <Foundation/Foundation.h>

@protocol IconSelectionViewDelegate <NSObject>

@optional

-(void) IconSelectionViewDelegate_iconSelected:(NSInteger) iconIndex;

@end
