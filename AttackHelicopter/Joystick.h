//
//  Joystick.h
//  Wheel
//
//  Created by edguo on 2014-04-13.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class Joystick;
@protocol JoystickDelegate
-(void)joystickVectorChange:(CGVector)vector;
-(void)joystickEnd;
@end

@interface Joystick : SKSpriteNode
-(id)initJoystick;
@property(nonatomic, weak) id<JoystickDelegate> delegate;
@property(nonatomic, weak) SKSpriteNode* joystickSprite;
@property(nonatomic) CGFloat joystickScale;
@end
