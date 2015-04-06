

#import "Angle.h"


CGFloat toRadians(CGFloat degrees) {
    return degrees / (180.0 * M_PI);
}

CGFloat toDegrees(CGFloat radians) {
    return radians * (180.0 / M_PI);
}


@interface Angle ()
@property (nonatomic) CGFloat angle;
@end


@implementation Angle

+ (instancetype)angleWithRadians:(CGFloat)radians {
    return [[Angle alloc] initWithRadians:radians];
}

+ (instancetype)angleWithDegrees:(CGFloat)degrees {
    return [[Angle alloc] initWithDegrees:degrees];
}

+ (instancetype)angleWithPiTimes:(CGFloat)ratio {
    return [[Angle alloc] initWithRadians:ratio * M_PI];
}

- (instancetype)initWithRadians:(CGFloat)radians {
    if (self = [super init]) {
        self.angle = radians;
    }
    return self;
}

- (instancetype)initWithDegrees:(CGFloat)degrees {
    if (self = [super init]) {
        _angle = toRadians(degrees);
    }
    return self;
}

- (CGFloat)toRadians {
    return self.angle;
}

- (CGFloat)toDegrees {
    return toDegrees(self.angle);
}

@end