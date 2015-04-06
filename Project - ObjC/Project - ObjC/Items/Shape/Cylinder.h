
@class Cylinder;


@protocol CylinderExport <JSExport>
+ (instancetype)create;
- (instancetype)create;
+ (instancetype) template;
//
- (void)destroy;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
//
@property (nonatomic, strong) id color;
@property (nonatomic, strong) id physics;
@property (nonatomic, strong) id velocity;
//
+ (instancetype)cylinder;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat height;
@end


/*!
 A cylinder, with speficiable height and radius.
 */
@interface Cylinder : Shape <CylinderExport>
/*!
 Creates a new instance of @p Cylinder, with the default measures set by @p
 SCNCylinder.
 @return a new, default instance of @p Cylinder.
 */
+ (instancetype)cylinder;

/*!
 An alias for the SCNCylinder's @p radius property. Speficies the radius used
 for the Cylinder's circular bases, aligned with the @p xz plane and centered in
 the origin.
 @see height
 */
@property (nonatomic) CGFloat radius;
/*!
 An alias for the SCNCylinder's @p height property. Speficies the extent of the
 cylinder in its @p y axis.
 @see radius
 */
@property (nonatomic) CGFloat height;
@end
