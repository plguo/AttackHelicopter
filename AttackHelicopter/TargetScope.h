//
//  TargetScope.h
//  Wheel
//
//  Created by edguo on 2014-04-14.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ENSprite.h"

@class TargetScope;
@protocol TargetScopeDelegate <NSObject>
-(void)targetPositionInScene:(CGPoint)point;
-(void)targetScopeEnd;
@end

@interface TargetScope : SKSpriteNode<ENSpriteDelegate>
-(id)initTargetScopeWithEnsprite:(ENSprite*)sprite;
-(void)updatePosition;
-(void)targetNewSprite:(ENSprite*)sprite;

@property(nonatomic, weak) id<TargetScopeDelegate> delegate;
@property(nonatomic, weak) ENSprite* trackingSprite;
@end
