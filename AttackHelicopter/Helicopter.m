//
//  Helicopter.m
//  Wheel
//
//  Created by edguo on 2014-04-13.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "Helicopter.h"
#define BULLET_FORCE 40.0

@implementation Helicopter
-(id)initHelicopter{
    if (self = [super initWithImageNamed:@"HelicopterImage"]) {
        self.healthMax = 200;
        self.health = self.healthMax;
        self.cannonTargeting = NO;
        
        Cannon* mainCannon = [[Cannon alloc]initCannon];
        mainCannon.position = CGPointMake(23, -9);
        [self addChild:mainCannon];
        self.cannon = mainCannon;
        
        SKTextureAtlas* tAtlas = [SKTextureAtlas atlasNamed:@"Propeller"];

        NSArray *textures = @[[tAtlas textureNamed:@"Propeller1"],
                              [tAtlas textureNamed:@"Propeller2"],
                              [tAtlas textureNamed:@"Propeller3"],
                              [tAtlas textureNamed:@"Propeller4"]];
        
        
        SKSpriteNode* propeller = [SKSpriteNode spriteNodeWithTexture:[tAtlas textureNamed:@"Propeller1"]];
        propeller.position = CGPointMake(4, 14);
        [self addChild:propeller];
        SKAction* spin = [SKAction animateWithTextures:textures  timePerFrame:0.04];
        [propeller runAction:[SKAction repeatActionForever:spin]];
        
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.categoryBitMask = CategoryHelicopter;
        self.physicsBody.contactTestBitMask = CategoryTile;
        self.physicsBody.collisionBitMask = CategoryNone;
    }
    return self;
}
-(void)targetNode:(SKNode *)node{
    self.cannonTargeting = YES;
    self.cannon.targetNode = node;
    //[self.cannon updateTargetPosition];
}

-(void)targetNodePositionDidChanged{
    [self.cannon updateTargetPosition];
}

-(NSTimeInterval)cannonWaitInterval{
    return self.cannon.shootInterval;
}
-(BOOL)shootBullet{
    if ([self.cannon cannonWillShoot]) {
        Bullet* newBullet = [[Bullet alloc] initWeapon];
        newBullet.position = [self convertPoint:self.cannon.position toNode:self.parent];
        
        newBullet.zRotation = self.cannon.barrel.zRotation + self.zRotation;
        
        newBullet.physicsBody.categoryBitMask = CategoryFriendWeapon;
        newBullet.physicsBody.contactTestBitMask = CategoryTile | CategoryEnemyObject | CategoryEnemyWeapon;
        
        [self.parent addChild:newBullet];
        [newBullet launchWeapon];
        return YES;
    }
    return NO;
}

-(void)setZRotation:(CGFloat)zRotation{
    [super setZRotation:zRotation];
    if (self.cannonTargeting) {
        [self.cannon updateRotation];
    }
}


-(void)damage:(uint8_t)lostHealth{
    if (lostHealth<self.health) {
        self.health -= lostHealth;
        if (self.healthDelegate) {
            [self.healthDelegate healthChange:(CGFloat)self.health/self.healthMax];
        }
    } else {
        if (self.delegate) {
            [self.delegate helicopterKilled];
        }
    }
}

-(void)stopLaunchRocket{
    
}

-(void)targetScopeEnd{
    [self.cannon rotateToNormalAngle];
    self.cannonTargeting = NO;
}

-(NSTimeInterval)rocketWaitInterval{
    return 0.3;
}

-(BOOL)launchRocket{
    Rocket* rocket = [[Rocket alloc]initWeapon];
    rocket.position = self.position;
    rocket.zRotation = self.zRotation;
    rocket.physicsBody.categoryBitMask = CategoryFriendWeapon;
    rocket.physicsBody.contactTestBitMask = CategoryTile | CategoryEnemyObject | CategoryEnemyWeapon;
    [self.parent addChild:rocket];
    [rocket launchWeapon];
    return YES;
}

@end
