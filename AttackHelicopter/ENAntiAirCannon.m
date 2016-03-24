//
//  ENAntiAirCannon.m
//  Wheel
//
//  Created by edguo on 2014-04-17.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "ENAntiAirCannon.h"
#define BULLET_FORCE 40.0
@implementation ENAntiAirCannon
-(id)initEnemySprite{
    if (self = [super initWithImageNamed:@"AACannonImage"]) {
        self.health = 40;
        self.reward = 10;
        
        SKSpriteNode* cannon = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(30, 4)];
        cannon.zPosition = - 0.5;
        cannon.anchorPoint = CGPointMake(0.0, 0.5);
        cannon.position = CGPointMake(5, 8);
        cannon.zRotation = M_PI_2;
        [self addChild:cannon];
        self.cannon = cannon;
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.categoryBitMask = CategoryEnemyObject;
        self.physicsBody.contactTestBitMask = CategoryHelicopter | CategoryFriendWeapon;
        self.physicsBody.collisionBitMask = CategoryTile;
    }
    return self;
}

-(void)startAction{
    SKAction * target = [SKAction performSelector:@selector(aimTarget) onTarget:self];
    SKAction * waitPeriod1 = [SKAction waitForDuration:1.5];
    SKAction * shoot = [SKAction performSelector:@selector(shootBullet) onTarget:self];
    SKAction * waitPeriod2 = [SKAction waitForDuration:0.3];
    
    SKAction * sequence = [SKAction sequence:@[target,waitPeriod1,shoot,waitPeriod2,shoot,waitPeriod2,shoot,waitPeriod2,shoot,waitPeriod2,shoot]];
    [self runAction:[SKAction repeatActionForever:sequence]];
}

-(void)shootBullet{
    Bullet* newBullet = [[Bullet alloc] initWeapon];
    newBullet.position = CGPointMake(self.position.x+self.cannon.position.x, self.position.y+self.cannon.position.y);
    newBullet.zRotation = self.cannon.zRotation + self.zRotation;
    newBullet.zPosition = - 1.0;
    newBullet.physicsBody.categoryBitMask = CategoryEnemyWeapon;
    //contract with tile/player/player's weapons
    newBullet.physicsBody.contactTestBitMask = CategoryTile | CategoryHelicopter | CategoryFriendWeapon;
    
    [self.parent addChild:newBullet];
    [newBullet launchWeapon];
}

-(void)aimTarget{
    if (self.targetNode) {
        CGPoint nodePointInScene = [self.scene convertPoint:CGPointZero fromNode:self.targetNode];
        CGPoint selfPointInScene = [self.scene convertPoint:self.cannon.position fromNode:self];
        CGVector relativeVector = CGVectorMake(nodePointInScene.x - selfPointInScene.x, nodePointInScene.y - selfPointInScene.y);
        
        CGFloat newAngle=0.0;
        if (relativeVector.dx == 0.0) {
            newAngle= 0.0;
        }else{
            newAngle = atan(relativeVector.dy/relativeVector.dx);
            if (relativeVector.dx>0.0) {
                if (relativeVector.dy<0.0) {
                    newAngle += M_PI*2;
                }
            }else{
                newAngle += M_PI;
            }
        }
        
        [self.cannon runAction:[SKAction rotateToAngle:newAngle duration:1.0 shortestUnitArc:YES]];
    }else{
        [self removeAllActions];
    }
}

@end
