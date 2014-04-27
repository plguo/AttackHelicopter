//
//  RocketButton.h
//  Wheel
//
//  Created by edguo on 2014-04-18.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class RocketButton;

@protocol RocketButtonDelegate <NSObject>
-(BOOL)launchRocket;
-(void)stopLaunchRocket;
-(NSTimeInterval)rocketWaitInterval;
@end

@interface RocketButton : SKSpriteNode
-(id)initButton;

@property(nonatomic, weak) UITouch* trackingTouch;
@property(nonatomic, weak) id<RocketButtonDelegate> delegate;
@end
