//
//  Cannon.h
//  Wheel
//
//  Created by edguo on 2014-04-14.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class Cannon;
@protocol CannonDelegate <NSObject>
-(void)AmmoDidChange;
-(void)cannonStartLoad;
-(void)cannonFinishedLoad;
@end

@interface Cannon : SKSpriteNode
-(id)initCannon;
-(void)updateTargetPosition;
-(void)rotateToNormalAngle;
-(BOOL)cannonWillShoot;
-(void)startReload;
-(void)updateRotation;

@property(nonatomic) CGFloat expectRotation;

@property(nonatomic) CGFloat loadTime;
@property(nonatomic) NSTimeInterval shootInterval;

@property(nonatomic) CGFloat minAngle;
@property(nonatomic) CGFloat maxAngle;
@property(nonatomic) CGFloat normalAngle;

@property(nonatomic) CGFloat rotateSpeed;

@property(nonatomic) NSUInteger maxAmmo;
@property(nonatomic) NSUInteger ammo;
@property(nonatomic) BOOL reloading;

@property(nonatomic, weak) SKSpriteNode* barrel;
@property(nonatomic, weak) id<CannonDelegate> delegate;

@property(nonatomic, weak) SKNode* targetNode;
@end
