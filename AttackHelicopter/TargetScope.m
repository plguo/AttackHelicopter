//
//  TargetScope.m
//  Wheel
//
//  Created by edguo on 2014-04-14.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "TargetScope.h"

@implementation TargetScope
-(id)initTargetScopeWithEnsprite:(ENSprite *)sprite{
    if (self = [super initWithImageNamed:@"targetScope"]) {
        self.trackingSprite = sprite;
        self.trackingSprite.delegate = self;
        self.userInteractionEnabled = YES;
        self.zPosition = 9.0;
    }
    return self;
}
-(void)spriteMoveToNewPosition{
    [self updatePosition];
}
-(void)spriteKilled{
    [self removeTargetScope];
}

-(void)updatePosition{
    CGPoint PositionInScene = [self.scene convertPoint:CGPointZero fromNode:self.trackingSprite];
    self.position = [self.parent convertPoint:PositionInScene
                              fromNode:self.scene];
    if (self.position.x < 0) {
        [self removeTargetScope];
    }
    if (self.delegate) {
        [self.delegate targetPositionInScene:PositionInScene];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self removeTargetScope];
}

-(void)removeTargetScope{
    if (self.delegate) {
        [self.delegate targetScopeEnd];
    }
    self.trackingSprite.delegate = nil;
    [self removeFromParent];
}

-(void)targetNewSprite:(ENSprite*)sprite{
    self.trackingSprite.delegate = nil;
    self.trackingSprite = sprite;
    sprite.delegate = self;
    
    [self runAction:[SKAction moveTo:[self.parent convertPoint:[self.scene convertPoint:CGPointZero fromNode:self.trackingSprite] fromNode:self.scene] duration:0.5] completion:^{
        [self updatePosition];
    }];
     
}

@end
