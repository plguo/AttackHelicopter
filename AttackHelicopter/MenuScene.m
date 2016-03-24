//
//  MenuScene.m
//  Wheel
//
//  Created by edguo on 2014-04-25.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "MenuScene.h"

@implementation MenuScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        
        SKSpriteNode* node1 = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(5*4, 12*4)];
        node1.position = CGPointMake(200, 150);
        [self addChild:node1];
        
        SKSpriteNode* arm1 = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(25*4,3*4)];
        arm1.anchorPoint = CGPointMake(0.1, 0.5);
        arm1.position = CGPointMake(0, 5*4);
        arm1.zRotation = - M_PI_4;
        [node1 addChild:arm1];
        self.arm1 = arm1;
        
        
        SKSpriteNode* arm2 = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(25*4,2*4)];
        arm2.anchorPoint = CGPointMake(0.1, 0.5);
        arm2.position = CGPointMake(25*4-20, 0);
        arm2.zRotation = M_PI;
        [arm1 addChild:arm2];
        self.arm2 = arm2;
        
        SKSpriteNode* arm3 = [SKSpriteNode spriteNodeWithColor:[SKColor purpleColor] size:CGSizeMake(14*4,4*4)];
        arm3.anchorPoint = CGPointMake(0.1, 0.5);
        arm3.position = CGPointMake(25*4-20, 0);
        arm3.zRotation = M_PI;
        [arm2 addChild:arm3];
        self.arm3 = arm3;
        
        SKSpriteNode* part1 = [SKSpriteNode spriteNodeWithColor:[SKColor purpleColor] size:CGSizeMake(1*4,4*4)];
        part1.anchorPoint = CGPointMake(0.5, 0.0);
        part1.position = CGPointMake(25*3/2, 0);
        [arm3 addChild:part1];
        
        SKSpriteNode* part2 = [SKSpriteNode spriteNodeWithColor:[SKColor purpleColor] size:CGSizeMake(1*4,4*4)];
        part2.anchorPoint = CGPointMake(0.5, 0.0);
        part2.position = CGPointMake(25*2/2, 0);
        [arm3 addChild:part2];
        
        
        ButtonNode* button = [ButtonNode buttonWithColor:[SKColor greenColor] size:CGSizeMake(50, 30) title:@"U+ 1"];
        button.name = @"UP1";
        button.delegate = self;
        button.position = CGPointMake(40,60);
        [self addChild:button];
        
        ButtonNode* button2 = [ButtonNode buttonWithColor:[SKColor greenColor] size:CGSizeMake(50, 30) title:@"D- 1"];
        button2.name = @"DOWN1";
        button2.delegate = self;
        button2.position = CGPointMake(40,20);
        [self addChild:button2];
        
        
        ButtonNode* button3 = [ButtonNode buttonWithColor:[SKColor greenColor] size:CGSizeMake(50, 30) title:@"U+ 2"];
        button3.name = @"UP2";
        button3.delegate = self;
        button3.position = CGPointMake(100,60);
        [self addChild:button3];
        
        ButtonNode* button4 = [ButtonNode buttonWithColor:[SKColor greenColor] size:CGSizeMake(50, 30) title:@"D- 2"];
        button4.name = @"DOWN2";
        button4.delegate = self;
        button4.position = CGPointMake(100,20);
        [self addChild:button4];
        
        
        ButtonNode* button5 = [ButtonNode buttonWithColor:[SKColor greenColor] size:CGSizeMake(50, 30) title:@"U+ 3"];
        button5.name = @"UP3";
        button5.delegate = self;
        button5.position = CGPointMake(160,60);
        [self addChild:button5];
        
        ButtonNode* button6 = [ButtonNode buttonWithColor:[SKColor greenColor] size:CGSizeMake(50, 30) title:@"D- 3"];
        button6.name = @"DOWN3";
        button6.delegate = self;
        button6.position = CGPointMake(160,20);
        [self addChild:button6];
    }
    return self;
}
-(void)touchDownOnButton:(ButtonNode *)button{
    if ([button.name isEqualToString:@"UP1"]) {
        [self.arm1 removeAllActions];
        [self.arm1 runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:0.5 duration:1.0]]];
    } else if ([button.name isEqualToString:@"DOWN1"]) {
        [self.arm1 removeAllActions];
        [self.arm1 runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:-0.5 duration:1.0]]];
        
        
    }else if ([button.name isEqualToString:@"UP2"]) {
        [self.arm2 removeAllActions];
        [self.arm2 runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:0.5 duration:1.0]]];
    } else if ([button.name isEqualToString:@"DOWN2"]) {
        [self.arm2 removeAllActions];
        [self.arm2 runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:-0.5 duration:1.0]]];
        
        
    }else if ([button.name isEqualToString:@"UP3"]) {
        [self.arm3 removeAllActions];
        [self.arm3 runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:0.5 duration:1.0]]];
    } else if ([button.name isEqualToString:@"DOWN3"]) {
        [self.arm3 removeAllActions];
        [self.arm3 runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:-0.5 duration:1.0]]];
    }
    
}
-(void)touchUpOnButton:(ButtonNode *)button{
    if ([button.name isEqualToString:@"UP1"]) {
        [self.arm1 removeAllActions];
    } else if ([button.name isEqualToString:@"DOWN1"]) {
        [self.arm1 removeAllActions];

        
        
    }else if ([button.name isEqualToString:@"UP2"]) {
        [self.arm2 removeAllActions];
    } else if ([button.name isEqualToString:@"DOWN2"]) {
        [self.arm2 removeAllActions];
        
        
    }else if ([button.name isEqualToString:@"UP3"]) {
        [self.arm3 removeAllActions];
    } else if ([button.name isEqualToString:@"DOWN3"]) {
        [self.arm3 removeAllActions];
    }
}
@end
