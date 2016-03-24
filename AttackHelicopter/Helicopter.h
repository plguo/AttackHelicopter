//
//  Helicopter.h
//  Wheel
//
//  Created by edguo on 2014-04-13.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Cannon.h"
#import "TargetScope.h"
#import "Bullet.h"
#import "RocketButton.h"
#import "ShootButton.h"
#import "Rocket.h"

@class Helicopter;

@protocol HelicopterHealthDelegate <NSObject>
-(void)healthChange:(CGFloat)precentage;
@end


@protocol HelicopterSceneDelegate <NSObject>
-(void)helicopterKilled;
@end

@interface Helicopter : SKSpriteNode<TargetScopeDelegate,RocketButtonDelegate,ShootButtonDelegate>
-(id)initHelicopter;
-(void)damage:(uint8_t)lostHealth;

@property(nonatomic) uint8_t healthMax;
@property(nonatomic) uint8_t health;
@property(nonatomic, weak) id<HelicopterSceneDelegate> delegate;
@property(nonatomic, weak) id<HelicopterHealthDelegate> healthDelegate;
@property(nonatomic, weak) Cannon* cannon;
@property(nonatomic) CGVector velocity;
@property(nonatomic) BOOL cannonTargeting;
@end
