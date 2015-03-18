

@protocol SphereExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
//
@property (nonatomic, strong) id color;
//
@property (nonatomic) CGFloat radius;
@end


@interface Sphere : Shape <SphereExport>
+ (instancetype)sphere;
@property (nonatomic) CGFloat radius;
@end

// Tube
// Capsule
// Torus
// Floor
// Text
// Shape
// Plane
// Pyramid