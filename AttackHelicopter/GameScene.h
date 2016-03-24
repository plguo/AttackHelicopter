//
//  GameScene.h
//  Wheel
//
//  Created by edguo on 2014-04-12.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TileMap.h"
#import "Helicopter.h"
#import "Joystick.h"
#import "TargetScope.h"
#import "MapsController.h"
#import "Bullet.h"
#import "ENSprite.h"
#import "HealthDisplayer.h"
#import "RocketButton.h"
#import "ShootButton.h"
#import "CategoryBitMaskOpition.h"
#import "PauseButton.h"
#import "AmmoDisplayer.h"
#import "SkyMap.h"

@interface GameScene : SKScene<SKPhysicsContactDelegate,JoystickDelegate,HelicopterSceneDelegate,PauseButtonDelegate>
-(id)initWithSize:(CGSize)size;
@property(nonatomic, weak) SKNode* interfaceLayer;
@property(nonatomic, weak) Helicopter* mainHelicopter;
@property(nonatomic, weak) TileMap* tileMap;
@property(nonatomic, weak) SKNode* gameWorld;
@property(nonatomic, weak) SKLabelNode* markLabel;
@property(nonatomic, weak) TargetScope* scope;
@property(nonatomic) MapsController * MController;
@property(nonatomic) NSUInteger playerMark;
@end
