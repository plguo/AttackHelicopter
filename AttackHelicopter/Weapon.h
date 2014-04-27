//
//  Weapon.h
//  Wheel
//
//  Created by edguo on 2014-04-14.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CategoryBitMaskOpition.h"

@interface Weapon : SKSpriteNode

-(id)initWeapon;
-(BOOL)isKillInDamage:(uint8_t)lostHealth;
-(void)explodeEffect;
-(void)launchWeapon;

@property(nonatomic) uint8_t health;
@property(nonatomic) uint8_t damage;
@end
