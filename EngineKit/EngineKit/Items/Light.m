

#import "Light.h"

#import "Sphere.h"

#import "UIColor+Extension.h"


@interface Light ()
@property (nonatomic, weak) SCNLight *light;
@end


static Sphere *selectionSphere;


@implementation Light

@synthesize selected = _selected;

- (instancetype)init {
    if (self = [super init]) {
        [self addSCNLight];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        [self addSCNLight];
    }
    return self;
}

- (void)addSCNLight {
    self.node.light = [SCNLight new];
    self.position = [[Position alloc] initWithX:0 Y:0 Z:10];
}

#pragma mark - Override

- (void)copyInfoTo:(Item *)item {
    [super copyInfoTo:item];

    if ([item isKindOfClass:[Light class]]) {
        Light *light = (Light *)item;
        light.type = self.type;
        light.color = self.color;
    }
}

#pragma mark - Property Overrides

- (void)setSelected:(BOOL)selected {
    if (_selected != selected) {
        if (!selectionSphere) {
            selectionSphere = [Sphere create];
            selectionSphere.radius = @(0.1);
            selectionSphere.color = @"yellow";
        }
        selectionSphere.hidden = !selected;

        if (selected) {
            selectionSphere.position = self.position;
        }
    }

    _selected = selected;
}

- (SCNLight *)light {
    return self.node.light;
}

- (void)setLight:(SCNLight *)light {
    self.node.light = light;
}

- (id)color {
    return self.light.color;
}

- (void)setColor:(id)newValue {
    UIColor *color = [UIColor colorWithObject:newValue];
    self.light.color = color;
}

- (void)setType:(NSString *)type {
    self.light.type = type;
}

- (NSString *)type {
    return self.light.type;
}

@end
