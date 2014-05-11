//
//  ENPlane.m
//  AttackHelicopter
//
//  Created by edguo on 2014-05-02.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "ENPlane.h"

@implementation ENPlane
-(id)initEnemySprite{
    if (self = [super initWithColor:[SKColor brownColor] size:CGSizeMake(30, 20)]) {
        self.health = 30;
        self.reward = 20;
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.categoryBitMask = CategoryEnemyObject;
        self.physicsBody.contactTestBitMask = CategoryHelicopter | CategoryFriendWeapon;
        self.physicsBody.collisionBitMask = CategoryTile;
    }
    return self;
}

-(void)startAction{
    /*
    SKAction * shoot = [SKAction performSelector:@selector(shootBullet) onTarget:self];
    SKAction * shortWait = [SKAction waitForDuration:0.3];
    SKAction * longWait = [SKAction waitForDuration:5.0];
    
    SKAction * sequence = [SKAction sequence:@[longWait,shoot,shortWait,shoot,shortWait,shoot,shortWait,shoot,shortWait,shoot]];
    [self runAction:[SKAction repeatActionForever:sequence]];
    
    SKAction* move = [SKAction moveByX:self.moveVector.dx y:0 duration:4.0];
    SKAction* up = [SKAction moveByX:self.moveVector.dy y:self.moveVector.dy duration:1.0];
    SKAction* remove = [SKAction removeFromParent];
    SKAction* moveSequence = [SKAction sequence:@[move,up,remove]];
    [self runAction:moveSequence];
     */
}

-(void)shootBullet{
    Bullet* newBullet = [[Bullet alloc] initWeapon];
    newBullet.position = self.position;
    newBullet.zRotation = M_PI_2 + self.zRotation;
    
    newBullet.physicsBody.categoryBitMask = CategoryEnemyWeapon;
    newBullet.physicsBody.contactTestBitMask = CategoryTile | CategoryHelicopter | CategoryFriendWeapon;
    
    [self.parent addChild:newBullet];
    [newBullet launchWeapon];
}

@end
