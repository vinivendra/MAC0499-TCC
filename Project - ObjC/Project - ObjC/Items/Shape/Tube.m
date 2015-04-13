

#import "Tube.h"


@implementation Tube

+ (instancetype)tube {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.tube = [SCNTube new];
    }
    return self;
}

- (instancetype)initWithInnerRadius:(CGFloat)innerRadius
                        outerRadius:(CGFloat)outerRadius
                             height:(CGFloat)height {
    if (self = [super init]) {
        self.tube = [SCNTube tubeWithInnerRadius:innerRadius
                                     outerRadius:outerRadius
                                          height:height];
    }
    return self;
}

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    [super copyPhysicsTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Tube *)item {
    [super copyInfoTo:item];
    
    item.outerRadius = self.outerRadius;
    item.innerRadius = self.innerRadius;
    item.height = self.height;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setTube:(SCNTube *)tube {
    self.geometry = tube;
}

- (SCNTube *)tube {
    return (SCNTube *)self.geometry;
}


- (void)setRadius:(NSNumber *)radius {
    [self assertTheresNoPhysicsBody];
    self.tube.outerRadius = radius.doubleValue;
}

- (NSNumber *)radius {
    return @(self.tube.outerRadius);
}

- (void)setInnerRadius:(NSNumber *)innerRadius {
    [self assertTheresNoPhysicsBody];
    self.tube.innerRadius = innerRadius.doubleValue;
}

- (NSNumber *)innerRadius {
    return @(self.tube.innerRadius);
}

- (void)setOuterRadius:(NSNumber *)outerRadius {
    [self assertTheresNoPhysicsBody];
    self.tube.outerRadius = outerRadius.doubleValue;
}

- (NSNumber *)outerRadius {
    return @(self.tube.outerRadius);
}

- (void)setHeight:(NSNumber *)height {
    [self assertTheresNoPhysicsBody];
    self.tube.height = height.doubleValue;
}

- (NSNumber *)height {
    return @(self.tube.height);
}

@end
