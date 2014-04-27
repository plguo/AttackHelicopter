//
//  Cannon.m
//  Wheel
//
//  Created by edguo on 2014-04-14.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "Cannon.h"

@implementation Cannon
-(id)initCannon{
    if (self = [super initWithImageNamed:@"CannonTower"]) {
        self.shootInterval = 0.2;
        self.loadTime = 0.2;
        
        self.minAngle = 5.0;
        self.maxAngle = 7.0;
        self.normalAngle = 6.0;
        
        self.rotateSpeed = 1.0;
        
        self.maxAmmo = 8;
        self.ammo = 8;
        
        SKSpriteNode* barrel = [SKSpriteNode spriteNodeWithImageNamed:@"CannonImage"];
        barrel.zPosition = -0.5;
        barrel.anchorPoint = CGPointMake(0.1, 0.5);
        barrel.zRotation = self.normalAngle;
        [self addChild:barrel];
        self.barrel = barrel;
    }
    return self;
}

-(void)updateRotation{
    [self rotateToAngle:self.expectRotation-self.parent.zRotation];
}

-(void)rotateToAngle:(CGFloat)angle{
    
    angle = MIN(MAX(angle, self.minAngle), self.maxAngle);
    
    CGFloat changeInAngle = angle - self.barrel.zRotation;
    NSTimeInterval time = (NSTimeInterval)fabs(changeInAngle)/self.rotateSpeed;
    
    if (time>0.1) {
        [self.barrel removeAllActions];
        [self.barrel runAction:[SKAction rotateByAngle:changeInAngle duration:time]];
    }else{
        [self.barrel removeAllActions];
        self.barrel.zRotation = angle;
    }
    
}

-(void)rotateToNormalAngle{
    [self rotateToAngle:self.normalAngle];
}

-(void)targetAtScenePosition:(CGPoint)relativePos{
    CGFloat newAngle=0.0;
    if (relativePos.x == 0.0) {
        newAngle= 0.0;
    }else{
        newAngle = atan(relativePos.y/relativePos.x);
        if (relativePos.x<0.0) {
            newAngle += M_PI;
        }else{
            newAngle += M_PI*2;
        }
    }
    self.expectRotation = newAngle;
    [self updateRotation];
}

-(void)reloadSingleBullet{
    
    if (self.ammo < self.maxAmmo) {
        self.ammo ++;
        if (self.delegate) {
            [self.delegate AmmoDidChange];
        }
        if (self.ammo == self.maxAmmo) {
            self.reloading = NO;
            if (self.delegate) {
                [self.delegate cannonFinishedLoad];
            }
        } else {
            SKAction *wait = [SKAction waitForDuration:self.loadTime];
            SKAction *load = [SKAction performSelector:@selector(reloadSingleBullet) onTarget:self];
            [self runAction:[SKAction sequence:@[wait,load]]];
        }
        
    }
}


-(void)startReload{
    if (self.ammo < self.maxAmmo) {
        if (self.delegate) {
            [self.delegate cannonStartLoad];
        }
        self.reloading = YES;
        SKAction *wait = [SKAction waitForDuration:self.loadTime];
        SKAction *load = [SKAction performSelector:@selector(reloadSingleBullet) onTarget:self];
        [self runAction:[SKAction sequence:@[wait,load]]];
    }
}

-(BOOL)cannonWillShoot{
    if (self.ammo > 0 && !self.reloading) {
        self.ammo --;
        if (self.delegate) {
            [self.delegate AmmoDidChange];
        }
        return YES;
    }else{
        [self startReload];
        return NO;
    }
}
@end
