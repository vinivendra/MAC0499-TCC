

#import "Axis.h"
#import "Angle.h"


/*!
 Represents a rotation by a determined angle around a determined axis.
 */
@interface Rotation : NSObject
/*!
 Creates a Rotation of @p angle radians around the given @p axis.
 @param axis  The Axis around which to rotate.
 @param angle The Angle by which to rotate.
 @return An initialized Rotation object.
 */
+ (instancetype)rotationWithAxis:(Axis *)axis angle:(Angle *)angle;
/*!
 Creates a Rotation based on the given NSArray. Trusts that the array has enough
 (4 or more) components, and that the first 4 components may be cast into @p
 NSNumbers.

 The first 3 numbers are used to create an Axis, and the fourth represents the
 angle for the rotation. This is much like the SCNVector4s are used for
 rotation.

 @param array The array representing the rotation.
 @return An initialized Rotation object.
 */
+ (instancetype)rotationWithArray:(NSArray *)array;
/*!
 Creates a Rotation based on the given object. The supported objects are:
 - NSArray, which will be initialized just like @p -initWithArray.
 - NSValue containing a SCNVector4, which will be initialized just like @p
 -initWithSCNVector4.

 @warning In case the object isn't a subclass of any of the above classes, an @p
 assert(false) will be triggered.

 @param object An object of any one of the classes mentioned above.
 @return An initialized Rotation object.
 @see -initWithArray
 @see -initWithSCNVector4
 */
+ (instancetype)rotationWithObject:(id)object;
/*!
 Creates a Rotation in which all components are set as just as the given
 SCNVector4. This initialization is a lot like @p -initWithArray.
 @param vector The SCNVector4 that should be used as a model.
 @return An initialized Rotation object.
 @see -initWithArray
 */
+ (instancetype)rotationWithSCNVector4:(SCNVector4)vector;
/*!
 Creates a Rotation in which all components are set as just as the given
 SCNVector4. This initialization is a lot like @p -initWithArray.
 @param vector The SCNVector4 that should be used as a model.
 @return An initialized Rotation object.
 @see -initWithArray
 */
- (instancetype)initWithSCNVector4:(SCNVector4)vector;
/*!
 Creates a Rotation of @p angle radians around the given @p axis.
 @param axis  The Axis around which to rotate.
 @param angle The Angle by which to rotate.
 @return An initialized Rotation object.
 */
- (instancetype)initWithAxis:(Axis *)axis angle:(Angle *)angle;
/*!
 Creates a Rotation based on the given NSArray. Trusts that the array has enough
 (4 or more) components, and that the first 4 components may be cast into @p
 NSNumbers.

 The first 3 numbers are used to create an Axis, and the fourth represents the
 angle for the rotation. This is much like the SCNVector4s are used for
 rotation.

 @param array The array representing the rotation.
 @return An initialized Rotation object.
 */
- (instancetype)initWithArray:(NSArray *)array;
/*!
 Creates a Rotation based on the given object. The supported objects are:

 - Rotation, which will create a copy of the given Rotation.

 - NSArray, which will be initialized just like @p -initWithArray.

 - NSValue containing a SCNVector4, which will be initialized just like @p
 -initWithSCNVector4.

 @warning In case the object isn't a subclass of any of the above classes, an @p
 assert(false) will be triggered.

 @param object An object of any one of the classes mentioned above.
 @return An initialized Rotation object.
 @see -initWithArray
 @see -initWithSCNVector4
 */
- (instancetype)initWithObject:(id)object;
/*!
 Initializes the receiver to copy the given rotation, such that is has the same
 values for its axis and angle.
 @param rotation The rotation from which to copy information.
 @return An initialized Rotation object.
 */
- (instancetype)initWithRotation:(Rotation *)rotation;

/*!
 The receiver applies the rotation it represents to the receiving SCNMatrix4,
 and then returns the result.
 @param matrix The matrix to rotate.
 @return A new SCNMatrix4, representing the result of the rotation of the
 original matrix.
 */
- (SCNMatrix4)rotateMatrix:(SCNMatrix4)matrix;

/*!
 Returns a representation of the Rotation as an SCNVector4. The Rotation's Axis
 will be represented in the first three components (x y z), while the angle will
 be in the last component (w). This is the most common representation, ready to
 be used with SceneKit.
 @return An initialized SCNVector4.
 */
- (SCNVector4)toSCNVector;
/*!
 Returns an SCNMatrix4 representing the same rotation as the receiver.
 @return An initialized SCNMatrix4.
 */
- (SCNMatrix4)toSCNMatrix;
/*!
 The x component of the axis around which the rotation is being done.
 */
- (CGFloat)x;
/*!
 The y component of the axis around which the rotation is being done.
 */
- (CGFloat)y;
/*!
 The z component of the axis around which the rotation is being done.
 */
- (CGFloat)z;
/*!
 The value of the angle by which the rotation is being done, in radians.
 */
- (CGFloat)a;
/*!
 The axis around which the rotation is being done.
 */
- (Axis *)axis;
/*!
 The angle by which the rotation is being done.
 */
- (Angle *)angle;
@end