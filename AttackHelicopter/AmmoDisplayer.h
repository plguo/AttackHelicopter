//
//  AmmoDisplayer.h
//  Wheel
//
//  Created by edguo on 2014-04-21.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Cannon.h"
@interface AmmoDisplayer : SKLabelNode<CannonDelegate>
-(id)initDisplayerWithCannon:(Cannon*)cannon;
@property(nonatomic, weak) Cannon* cannon;
@end
