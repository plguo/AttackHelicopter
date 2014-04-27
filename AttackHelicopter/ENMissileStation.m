//
//  ENMissileStation.m
//  Wheel
//
//  Created by edguo on 2014-04-19.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "ENMissileStation.h"
#import "BadMissile.h"
@implementation ENMissileStation
-(id)initEnemySprite{
    if (self = [super initWithImageNamed:@"MissileStation"]) {
        self.health = 40;
        self.reward = 10;
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.categoryBitMask = CategoryEnemyObject;
        self.physicsBody.contactTestBitMask = CategoryHelicopter | CategoryFriendWeapon;
        self.physicsBody.collisionBitMask = CategoryTile;
    }
    return self;
}

-(void)startAction{
    SKAction * wait = [SKAction waitForDuration:6.0];
    SKAction * shoot = [SKAction performSelector:@selector(shootMissile) onTarget:self];
    
    SKAction * sequence = [SKAction sequence:@[shoot,wait]];
    [self runAction:[SKAction repeatActionForever:sequence]];
}

-(void)shootMissile{
    if (self.targetNode) {
        
        CGPoint nodePointInScene = [self.scene convertPoint:CGPointZero fromNode:self.targetNode];
        CGPoint selfPointInScene = [self.scene convertPoint:CGPointZero fromNode:self];
        CGPoint relativePosition = CGPointMake(nodePointInScene.x - selfPointInScene.x, nodePointInScene.y - selfPointInScene.y);
        
        BadMissile* missile = [[BadMissile alloc]initWeapon];
        missile.position = CGPointMake(self.position.x, self.position.y + 10);
        missile.zRotation = M_PI_2 + M_PI_4 + self.zRotation;
        missile.zPosition = self.zPosition - 1.0;
        missile.physicsBody.categoryBitMask = CategoryEnemyWeapon;
        missile.physicsBody.contactTestBitMask = CategoryTile | CategoryHelicopter | CategoryFriendWeapon;
        [self.parent addChild:missile];
        [missile launchWeaponWithTargetOffset:relativePosition];
    }
}
@end
