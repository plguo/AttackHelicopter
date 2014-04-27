//
//  FlakBullet.m
//  Wheel
//
//  Created by edguo on 2014-04-19.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "FlakBullet.h"

@implementation FlakBullet
-(id)initWeapon{
    if (self = [super initWithImageNamed:@"FlakBulletImage"]) {
        self.health = 0;
        self.damage = 40;
        
        [self setupPhysicsBodyWithRadius:self.size.width/2];
    }
    return self;
}

-(void)setupPhysicsBodyWithRadius:(CGFloat)radius{
    uint32_t oldContactTestBitMask = self.physicsBody.contactTestBitMask;
    uint32_t oldCategoryBitMask = self.physicsBody.categoryBitMask;
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.collisionBitMask = CategoryNone;
    self.physicsBody.contactTestBitMask = oldContactTestBitMask;
    self.physicsBody.categoryBitMask = oldCategoryBitMask;
}

-(void)explodeEffect{
    [self removeAllActions];
    
    SKEmitterNode *sparkNode = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"]];
    sparkNode.position = self.position;
    [self.parent addChild:sparkNode];
    
    SKAction *wait = [SKAction waitForDuration:0.3];
    SKAction* remove = [SKAction removeFromParent];
    [sparkNode runAction:[SKAction sequence:@[wait,remove]]];
    
}

-(void)explosion{
    self.damage = 10;
    [self setupPhysicsBodyWithRadius:self.size.width*3];
    self.alpha = 0.0;
    
    SKEmitterNode *smokeNode = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"BlackSmokeA" ofType:@"sks"]];
    smokeNode.position = self.position;
    [self.parent addChild:smokeNode];
    
    SKAction *wait = [SKAction waitForDuration:1.0];
    SKAction* remove = [SKAction removeFromParent];
    [smokeNode runAction:[SKAction sequence:@[wait,remove]]];
}

-(void)launchWeapon{
    SKAction* wait = [SKAction waitForDuration:0.8 withRange:0.3];
    SKAction* expand = [SKAction performSelector:@selector(explosion) onTarget:self];
    SKAction* wait2 = [SKAction waitForDuration:0.3];
    SKAction* remove = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[wait,expand,wait2,remove]]];
    
    [self.physicsBody applyForce:CGVectorMake(cos(self.zRotation)*200.0,sin(self.zRotation)*200.0)];
}
@end
