

#import <UIKit/UIKit.h>


typedef UIColor Color;


@interface UIColor (Extension)
+ (Color *)colorWithCArray:(CGFloat[4])array;
- (Color *)times:(CGFloat)scalar;
@end
