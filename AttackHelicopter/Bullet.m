//
//  Bullet.m
//  Wheel
//
//  Created by edguo on 2014-04-17.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

-(id)initWeapon{
    if (self = [super initWithImageNamed:@"BulletImage"]) {
        self.health = 0;
        self.damage = 5;
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.allowsRotation = NO;
        self.physicsBody.collisionBitMask = 0;
    }
    return self;
}


-(void)explodeEffect{
    SKEmitterNode *sparkNode = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"SparkA" ofType:@"sks"]];
    sparkNode.zRotation = self.zRotation + M_PI;
    sparkNode.position = self.position;
    SKAction* wait   = [SKAction waitForDuration:0.1];
    SKAction* remove = [SKAction removeFromParent];
    [sparkNode runAction:[SKAction sequence:@[wait,remove]]];
    [self.parent addChild:sparkNode];
}

-(void)launchWeapon{
    SKAction *move = [SKAction moveBy:CGVectorMake(1200.0*cos(self.zRotation), 1200.0*sin(self.zRotation)) duration:3.0];
    SKAction* remove = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[move,remove]]];
}

@end
