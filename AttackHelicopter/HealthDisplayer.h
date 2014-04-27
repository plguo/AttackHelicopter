//
//  HealthDisplayer.h
//  Wheel
//
//  Created by edguo on 2014-04-18.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Helicopter.h"

@interface HealthDisplayer : SKSpriteNode<HelicopterHealthDelegate>
-(id)initDisplayer;
@property(nonatomic) CGFloat healthBarMaxWidth;
@property(nonatomic, weak) SKSpriteNode* healthBar;
@end
