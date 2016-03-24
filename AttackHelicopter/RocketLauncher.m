//
//  RocketLauncher.m
//  AttackHelicopter
//
//  Created by edguo on 2014-05-19.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "RocketLauncher.h"

@implementation RocketLauncher

-(void)reloadSingleRocket{
    
    if (self.ammo < self.maxAmmo) {
        self.ammo ++;
        if (self.delegate) {
            [self.delegate rocketsDidChange];
        }
        if (self.ammo == self.maxAmmo) {
            self.reloading = NO;
            if (self.delegate) {
                [self.delegate rocketFinishedLoad];
            }
        } else {
            SKAction *wait = [SKAction waitForDuration:self.loadTime];
            SKAction *load = [SKAction performSelector:@selector(reloadSingleRocket) onTarget:self];
            [self runAction:[SKAction sequence:@[wait,load]]];
        }
        
    }
}


-(void)startReload{
    if (self.ammo < self.maxAmmo) {
        if (self.delegate) {
            [self.delegate rocketStartLoad];
        }
        self.reloading = YES;
        SKAction *wait = [SKAction waitForDuration:self.loadTime];
        SKAction *load = [SKAction performSelector:@selector(reloadSingleRocket) onTarget:self];
        [self runAction:[SKAction sequence:@[wait,load]]];
    }
}

-(BOOL)cannonWillShoot{
    if (self.ammo > 0 && !self.reloading) {
        self.ammo --;
        if (self.delegate) {
            [self.delegate rocketsDidChange];
        }
        return YES;
    }else{
        [self startReload];
        return NO;
    }
}
@end
