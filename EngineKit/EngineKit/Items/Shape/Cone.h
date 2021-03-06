

#import "Shape.h"


@protocol ConeExport <JSExport>
- (instancetype)initAndAddToScene;
- (instancetype)create;
+ (instancetype)create;
+ (instancetype) template;
- (void)addItem:(Item *)newItem;
- (void)rotate:(id)rotation;
@property (nonatomic, weak, readonly) Item *parent;
@property (nonatomic, strong) NSString *templateName;
@property (nonatomic, strong) id materials;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
@property (nonatomic) BOOL isDefault;
@property (nonatomic) BOOL isTemplateBase;
@property (nonatomic) BOOL hidden;
- (void)setPositionX:(NSNumber *)newValue;
- (void)setPositionY:(NSNumber *)newValue;
- (void)setPositionZ:(NSNumber *)newValue;
- (void)setScaleX:(NSNumber *)newValue;
- (void)setScaleY:(NSNumber *)newValue;
- (void)setScaleZ:(NSNumber *)newValue;
- (void)setRotationX:(NSNumber *)newValue;
- (void)setRotationY:(NSNumber *)newValue;
- (void)setRotationZ:(NSNumber *)newValue;
- (void)setRotationA:(NSNumber *)newValue;
- (void)addPosition:(id)object;
- (void)addScale:(id)object;
- (NSNumber *)positionX;
- (NSNumber *)positionY;
- (NSNumber *)positionZ;
- (NSNumber *)scaleX;
- (NSNumber *)scaleY;
- (NSNumber *)scaleZ;
- (NSNumber *)rotationX;
- (NSNumber *)rotationY;
- (NSNumber *)rotationZ;
- (NSNumber *)rotationA;
- (void)addPositionX:(NSNumber *)newValue;
- (void)addPositionY:(NSNumber *)newValue;
- (void)addPositionZ:(NSNumber *)newValue;
- (void)addScaleX:(NSNumber *)newValue;
- (void)addScaleY:(NSNumber *)newValue;
- (void)addScaleZ:(NSNumber *)newValue;
- (void)addRotationX:(NSNumber *)newValue;
- (void)addRotationY:(NSNumber *)newValue;
- (void)addRotationZ:(NSNumber *)newValue;
- (void)addRotationA:(NSNumber *)newValue;
//
@property (nonatomic, strong) id color;
@property (nonatomic, strong) id physics;
@property (nonatomic, strong) id velocity;
//
+ (instancetype)cone;
@property (nonatomic) NSNumber *radius;
@property (nonatomic) NSNumber *topRadius;
@property (nonatomic) NSNumber *bottomRadius;
@property (nonatomic) NSNumber *height;
@end


/*!
 A cone, which is may be whole or cut off at the top (like a conical frustrum).
 */
@interface Cone : Shape <ConeExport>
/*!
 Creates a new instance of @p Cone, with the default measures set by @p
 SCNCone.
 @return a new, default instance of @p Cone.
 */
+ (instancetype)cone;

/*!
 An alias for the SCNCone's @p bottomRadius property. Speficies the radius used
 for the Cone's base, which is very intuitive when the Cone is not a frustrum.
 The base is aligned with the @p xz plane and is centered in the origin.
 @see topRadius
 @see height
 */
@property (nonatomic) NSNumber *radius;
/*!
 An alias for the SCNCone's @p bottomRadius property. Speficies the radius used
 for the Cone's base, which is very intuitive when the Cone is not a frustrum.
 The base is aligned with the @p xz plane and is centered in the origin.
 @see topRadius
 @see height
 */
@property (nonatomic) NSNumber *bottomRadius;
/*!
 An alias for the SCNCone's @p topRadius property. Speficies the radius used
 for the Cone's top circle when it is a conical frustrum. A top radius of 0 is
 the default and results in an ordinary cone. The top circle is aligned with the
 @p xz plane and is centered in the origin.
 @see bottomRadius
 @see height
 */
@property (nonatomic) NSNumber *topRadius;
/*!
 An alias for the SCNCone's @p height property. Speficies the extent of the cone
 along the @p y axis.
 @see bottomRadius
 @see topRadius
 */
@property (nonatomic) NSNumber *height;
@end
