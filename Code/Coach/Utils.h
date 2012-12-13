#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (UIColor *)lighterColorForColor:(UIColor *)c;
+ (UIColor *)darkerColorForColor:(UIColor *)c;

+(void) playSound:(NSString*) path type:(NSString*) type;

@end
