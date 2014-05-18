//
//  SkyMap.m
//  AttackHelicopter
//
//  Created by edguo on 2014-05-12.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "SkyMap.h"
#define MIN_HEIGHT 150.0
#define MIN_SPACE 20.0
#define START_X 100.0
#define MAX_CHILD 4

@implementation SkyMap
-(void)startAction{
    
    SKAction* wait = [SKAction waitForDuration:25.0 withRange:20.0];
    SKAction* add  = [SKAction performSelector:@selector(addCloud) onTarget:self];
    SKAction* sequence = [SKAction sequence:@[add,wait]];
    SKAction* loop = [SKAction repeatActionForever:sequence];
    [self runAction:loop];
    
}

-(void)addCloud{
    NSLog(@"H");
    if (self.scene && [self.children count]<MAX_CHILD) {
        CGFloat lowerBound = MIN_HEIGHT;
        uint32_t range     = (uint32_t)self.scene.size.height- MIN_SPACE;
        
        CGFloat randomY       = (arc4random() % range)+lowerBound ;
        CGPoint cloudPosition = CGPointMake(self.scene.size.width+START_X, randomY);
        
        SKSpriteNode* cloud = [SKSpriteNode spriteNodeWithImageNamed:@"clouds_tk"];
        cloud.position      = cloudPosition;
        [self addChild:cloud];
        
        SKAction* move     = [SKAction moveToX:-START_X duration:60.0];
        SKAction* remove   = [SKAction removeFromParent];
        SKAction* sequence = [SKAction sequence:@[move,remove]];
        
        [cloud runAction:sequence];
    }
}
@end
