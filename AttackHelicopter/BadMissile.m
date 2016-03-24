//
//  BadMissile.m
//  Wheel
//
//  Created by edguo on 2014-04-20.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "BadMissile.h"

@implementation BadMissile
-(id)initWeapon{
    if (self = [super initWithImageNamed:@"MissileImage"]) {
        self.health = 10;
        self.damage = 40;
        self.alpha = 0.0;
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.collisionBitMask = CategoryNone;
    }
    return self;
}

-(void)explodeEffect{
    SKEmitterNode *sparkNode = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"]];
    sparkNode.position = self.position;
    [self.parent addChild:sparkNode];
    
    SKAction *wait = [SKAction waitForDuration:0.3];
    SKAction* remove = [SKAction removeFromParent];
    [sparkNode runAction:[SKAction sequence:@[wait,remove]]];
}

-(void)launchWeaponWithTargetOffset:(CGPoint)offest{
    CGFloat offestX = offest.x;
    if (offest.x > 100) {
        offestX -= 100;
    }else if (offest.x < -100){
        offestX += 100;
    }
    
    CGFloat cp1x = cos(self.zRotation)*100;
    CGFloat cp1y = sin(self.zRotation)*100;
    
    CGFloat cp2x = 0;
    CGFloat cp2y = offest.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddCurveToPoint(path, NULL, cp1x, cp1y, cp2x, cp2y, offestX , offest.y);
    
    SKAction* followPath = [SKAction followPath:path asOffset:YES orientToPath:YES duration:3.0];
    
    CGPathRelease(path);
    
    [self runAction:followPath completion:^{
            [self.physicsBody applyImpulse:CGVectorMake(cos(self.zRotation+M_PI_2)*0.5, sin(self.zRotation+M_PI_2)*0.5)];
    }];
    self.alpha = 1.0;
    
    SKEmitterNode *sparkNode = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"RocketFire" ofType:@"sks"]];
    sparkNode.zPosition = - 1.0;
    sparkNode.position = CGPointMake(0,-self.size.height/2-2.0);
    sparkNode.zRotation = M_PI_2;
    [self addChild:sparkNode];
    
    SKAction* wait = [SKAction waitForDuration:8.0];
    SKAction* remove = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[wait,remove]]];
    
}
@end
