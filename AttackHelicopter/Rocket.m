//
//  Rocket.m
//  Wheel
//
//  Created by edguo on 2014-04-18.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "Rocket.h"

@implementation Rocket
-(id)initWeapon{
    if (self = [super initWithImageNamed:@"RocketImage"]) {
        self.health = 0;
        self.damage = 20;
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.dynamic = YES;
        self.physicsBody.allowsRotation = YES;
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

-(void)launchWeapon{
    SKEmitterNode *sparkNode = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"RocketFire" ofType:@"sks"]];
    sparkNode.zPosition = - 1.0;
    sparkNode.position = CGPointMake(-self.size.width/2-2.0, 0);
    [self addChild:sparkNode];
    
    SKAction *wait5 = [SKAction waitForDuration:5.0];
    SKAction* remove = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[wait5,remove]]];
    
    [self.physicsBody applyImpulse:CGVectorMake(cos(self.zRotation)*1.5,sin(self.zRotation)*1.5)];
}
@end
