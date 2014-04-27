//
//  ShootButton.h
//  Wheel
//
//  Created by edguo on 2014-04-18.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class ShootButton;

@protocol ShootButtonDelegate <NSObject>
-(BOOL)shootBullet;
-(NSTimeInterval)cannonWaitInterval;
@end

@interface ShootButton : SKSpriteNode
-(id)initShootButton;
@property(nonatomic, weak) id<ShootButtonDelegate> delegate;
@property(nonatomic) UITouch* trackingTouch;

@end
