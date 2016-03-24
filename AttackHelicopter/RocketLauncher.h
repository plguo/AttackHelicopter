//
//  RocketLauncher.h
//  AttackHelicopter
//
//  Created by edguo on 2014-05-19.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class RocketLauncher;

@protocol RocketDelegate <NSObject>
-(void)rocketsDidChange;
-(void)rocketStartLoad;
-(void)rocketFinishedLoad;
@end

@interface RocketLauncher : SKSpriteNode


@property(nonatomic) CGFloat loadTime;
@property(nonatomic) NSTimeInterval shootInterval;

@property(nonatomic) NSUInteger maxAmmo;
@property(nonatomic) NSUInteger ammo;
@property(nonatomic) BOOL reloading;

@property(nonatomic,weak) id<RocketDelegate> delegate;
@end
