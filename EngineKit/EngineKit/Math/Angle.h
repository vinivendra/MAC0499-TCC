

#import <JavaScriptCore/JavaScriptCore.h>


@class Angle;


@protocol AngleExport <JSExport>
- (instancetype)initWithObject:(id)object;

- (CGFloat)toRadians;
- (CGFloat)toDegrees;
@end

/*!
 Represents an Angle, usually for a Rotation. Used mostly for initialization and
 conversion. More efficient when used exclusively with radians, but not slow
 unless used in a very tight loop.
 */
@interface Angle : NSObject<AngleExport>
/*!
 Creates an Angle object with the value of @p ratio*pi, measured in radians.
 @param ratio The value used to multiply by pi.
 @return An initialized Angle object.
 */
- (instancetype)initWithPiTimes:(CGFloat)ratio;
/*!
 Creates an Angle object with the given value in radians.
 @param radians An angle measured in radians.
 @return An initialized Angle object.
 */
- (instancetype)initWithRadians:(CGFloat)radians NS_DESIGNATED_INITIALIZER;
/*!
 Creates an Angle object with the given value in degrees.
 @param degrees An angle measured in degrees.
 @return An initialized Angle object.
 */
- (instancetype)initWithDegrees:(CGFloat)degrees NS_DESIGNATED_INITIALIZER;
/*!
 Creates an Angle object with the given value in radians. Uses NSNumber's
 numberWithObject method to obtain the value from the given object.
 @param object An angle measured in degrees.
 @return An initialized Angle object.
 @see [NSNumber numberWithObject]
 */
- (instancetype)initWithObject:(id)object NS_DESIGNATED_INITIALIZER;
/*!
 Converts the value of the Angle to radians.
 @return The Angle's value, measured in radians.
 */
@property (nonatomic, readonly) CGFloat toRadians;
/*!
 Converts the value of the Angle to degrees.
 @return The Angle's value, measured in degrees.
 */
@property (nonatomic, readonly) CGFloat toDegrees;
/*!
 Tests the receiver and the given object for equality.
 @param object The object to test for equality with the receiver.
 @return A boolean value indicating if the objects are equal.
 */
- (BOOL)isEqual:(id)object;
@end
