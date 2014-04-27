//
//  ENSprite.m
//  Wheel
//
//  Created by edguo on 2014-04-17.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "ENSprite.h"

@implementation ENSprite

-(id)initEnemySprite{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)startAction{
    
}

-(void)stopAction{
    [self removeAllActions];
}

-(BOOL)isKillInDamage:(uint8_t)lostHealth{
    if (lostHealth<self.health) {
        self.health -= lostHealth;
        return NO;
    } else {
        if (self.delegate) {
            [self.delegate spriteKilled];
        }
        return YES;
    }
}

-(void)setPosition:(CGPoint)position{
    [super setPosition:position];
    if (self.delegate) {
        [self.delegate spriteMoveToNewPosition];
    }
}

@end
