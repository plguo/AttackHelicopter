//
//  Weapon.m
//  Wheel
//
//  Created by edguo on 2014-04-14.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "Weapon.h"

@implementation Weapon
-(id)initWeapon{
    if(self = [super init]){
        
    }
    return self;
}


-(BOOL)isKillInDamage:(uint8_t)lostHealth{
    if (lostHealth<self.health) {
        self.health -= lostHealth;
        return NO;
    } else {
        return YES;
    }
}

-(void)explodeEffect{
    
}

-(void)launchWeapon{
    
}
@end
