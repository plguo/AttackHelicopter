//
//  MenuScene.h
//  Wheel
//
//  Created by edguo on 2014-04-25.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ButtonNode.h"
@interface MenuScene : SKScene<ButtonNodeDelegate>

@property(nonatomic,weak) SKSpriteNode* arm1;
@property(nonatomic,weak) SKSpriteNode* arm2;
@property(nonatomic,weak) SKSpriteNode* arm3;
@end
