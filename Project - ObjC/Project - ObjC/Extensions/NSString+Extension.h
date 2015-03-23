

#import <Foundation/Foundation.h>


@interface NSString (Extension)
/*!
 The value of the string as an NSNumber. Obtained by using the string's
 doubleValue property, so it follows basically the same rules.
 @see doubleValue
 */
@property (nonatomic, readonly, weak) NSNumber *numberValue;

/*!
 Checks if the string is empty or contains only whitespace.
 @return @p YES if the string is valid, @p NO otherwise.
 */
- (BOOL)valid;
@end
