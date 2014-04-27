//
//  HealthDisplayer.m
//  Wheel
//
//  Created by edguo on 2014-04-18.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "HealthDisplayer.h"

@implementation HealthDisplayer
-(id)initDisplayer{
    if (self = [super initWithColor:[SKColor blueColor] size:CGSizeMake(60, 20)]) {
        self.healthBarMaxWidth = 50;
        
        SKSpriteNode* healthBar = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(self.healthBarMaxWidth, 10)];
        healthBar.anchorPoint = CGPointMake(0,0.5);
        healthBar.position = CGPointMake(-healthBar.size.width/2, 0);
        [self addChild:healthBar];
        self.healthBar = healthBar;
    }
    return self;
}

-(void)healthChange:(CGFloat)precentage{
    [self.healthBar removeAllActions];
    [self.healthBar runAction:[SKAction resizeToWidth:self.healthBarMaxWidth*precentage duration:0.5]];
}
@end
