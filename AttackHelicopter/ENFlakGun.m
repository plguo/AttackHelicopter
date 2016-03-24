//
//  ENFlakGun.m
//  Wheel
//
//  Created by edguo on 2014-04-19.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "ENFlakGun.h"
#define MAX_BARREL_ANGLE M_PI
#define MIN_BARREL_ANGLE 1.6

@implementation ENFlakGun
-(id)initEnemySprite{
    if (self = [super initWithImageNamed:@"FlakGunImage"]) {
        self.health = 30;
        self.reward = 10;
        
        SKSpriteNode* barrel = [SKSpriteNode spriteNodeWithImageNamed:@"FlakGunBarrel"];
        barrel.anchorPoint = CGPointMake(0.1, 0.72);
        barrel.position = CGPointMake(8.0, 8.0);
        barrel.zPosition = -0.5;
        barrel.zRotation = MAX_BARREL_ANGLE;
        [self addChild:barrel];
        self.gunBarrel = barrel;
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.categoryBitMask = CategoryEnemyObject;
        self.physicsBody.contactTestBitMask = CategoryHelicopter | CategoryFriendWeapon;
        self.physicsBody.collisionBitMask = CategoryTile;
    }
    return self;
}

-(void)shootBullet{
    FlakBullet* newBullet = [[FlakBullet alloc] initWeapon];
    newBullet.position = CGPointMake(self.position.x+self.gunBarrel.position.x, self.position.y+self.gunBarrel.position.y);
    newBullet.zRotation = self.gunBarrel.zRotation + self.zRotation;
    newBullet.zPosition = -1.0;
    newBullet.physicsBody.categoryBitMask = CategoryEnemyWeapon;
    //contract with tile/player/player's weapons
    newBullet.physicsBody.contactTestBitMask = CategoryTile | CategoryHelicopter | CategoryFriendWeapon;
    newBullet.physicsBody.collisionBitMask = CategoryTile;
    
    [self.parent addChild:newBullet];
    [newBullet launchWeapon];
}

-(void)aimTarget{
    if (self.targetNode && self.parent) {
        CGPoint nodePointInScene = [self.scene convertPoint:CGPointZero fromNode:self.targetNode];
        CGPoint selfPointInScene = [self.scene convertPoint:self.gunBarrel.position fromNode:self];
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
        newAngle -= self.zRotation;
        newAngle = MAX(MIN_BARREL_ANGLE, newAngle);
        newAngle = MIN(MAX_BARREL_ANGLE, newAngle);
        
        
        SKAction* rotate = [SKAction rotateToAngle:newAngle duration:1.8 shortestUnitArc:YES];
        SKAction* wait = [SKAction waitForDuration:0.5 withRange:0.4];
        SKAction* shoot = [SKAction performSelector:@selector(shootBullet) onTarget:self];
        SKAction* aim = [SKAction performSelector:@selector(aimTarget) onTarget:self];
        SKAction* sequence = [SKAction sequence:@[rotate,wait,shoot,aim]];
        
        [self.gunBarrel runAction:sequence];
    }else{
        [self removeAllActions];
    }
}

-(void)startAction{
    [self aimTarget];
}
@end
