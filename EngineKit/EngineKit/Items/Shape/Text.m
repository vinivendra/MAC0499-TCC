

#import "Text.h"


@implementation Text

- (NSArray <NSString *>*)numericProperties {
    return @[@"depth",
             @"string"];
}

+ (instancetype)text {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.text = [SCNText new];
    self.color = @"lightGray";
}

- (instancetype)initWithString:(id)string depth:(CGFloat)depth {
    if (self = [super initAndAddToScene]) {
        self.text = [SCNText textWithString:string extrusionDepth:depth];
        self.color = @"lightGray";
    }
    return self;
}

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    [super copyPhysicsTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Text *)item {
    [super copyInfoTo:item];

    item.depth = self.depth;
    item.string = self.string;
}

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Text *)template {
    NSMutableArray *statements = [NSMutableArray new];

    if (![self.depth isEqual:template.depth]) {
        [statements addObject:[NSString stringWithFormat:@"depth is %@",
                               self.depth]];
    }
    if (![self.string isEqualToString:template.string]) {
        [statements addObject:[NSString stringWithFormat:@"string is %@",
                               self.string]];
    }

    NSMutableArray *superStatements;
    superStatements = [super propertyStringsBasedOnTemplate:template];
    statements = [[statements arrayByAddingObjectsFromArray:superStatements]
                  mutableCopy];
    return statements;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setText:(SCNText *)text {
    self.geometry = text;
}

- (SCNText *)text {
    return (SCNText *)self.geometry;
}


- (void)setString:(id)string {
    self.text.string = string;
}

- (id)string {
    return self.text.string;
}

- (void)setDepth:(NSNumber *)depth {
    self.text.extrusionDepth = depth.doubleValue;
}

- (NSNumber *)depth {
    return @(self.text.extrusionDepth);
}

@end
