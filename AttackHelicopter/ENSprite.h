//
//  ENSprite.h
//  Wheel
//
//  Created by edguo on 2014-04-17.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CategoryBitMaskOpition.h"

@class ENSprite;
@protocol ENSpriteDelegate <NSObject>
-(void)spriteMoveToNewPosition;
-(void)spriteKilled;
@end

@interface ENSprite : SKSpriteNode
-(id)initEnemySprite;
-(BOOL)isKillInDamage:(uint8_t)lostHealth;
-(void)startAction;
-(void)stopAction;
@property(nonatomic, weak) SKNode* targetNode;
@property(nonatomic, weak) id<ENSpriteDelegate> delegate;
@property(nonatomic) uint8_t health;
@property(nonatomic) uint8_t reward;
@end
