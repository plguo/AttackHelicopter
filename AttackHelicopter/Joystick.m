//
//  Joystick.m
//  Wheel
//
//  Created by edguo on 2014-04-13.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "Joystick.h"
#define RADIUS 20
#define RADIUS_SQ 400.0
@implementation Joystick

-(id)initJoystick{
    if (self = [super initWithImageNamed:@"JoystickBack"]) {
        self.userInteractionEnabled = YES;
        SKSpriteNode* joystickSprite = [SKSpriteNode spriteNodeWithImageNamed:@"JoystickFront"];
        joystickSprite.position = CGPointZero;
        [self addChild:joystickSprite];
        self.joystickSprite = joystickSprite;
        self.joystickScale = 1.0;
    }
    return self;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    CGPoint newPosition = [[touches anyObject] locationInNode:self];
    if ((newPosition.x*newPosition.x+newPosition.y*newPosition.y)<RADIUS_SQ) {
        self.joystickSprite.position = newPosition;
        [self.delegate joystickVectorChange:CGVectorMake(newPosition.x*self.joystickScale, newPosition.y*self.joystickScale)];
    }else{
        CGFloat angle = atan(newPosition.x/newPosition.y);
        if (newPosition.y == 0) {
            if (newPosition.x>0) {
                self.joystickSprite.position = CGPointMake(RADIUS, 0);
            }else{
                self.joystickSprite.position = CGPointMake(-RADIUS, 0);
            }
        }else if (newPosition.y>0) {
            self.joystickSprite.position = CGPointMake(sin(angle)*RADIUS, cos(angle)*RADIUS);
        }else{
            self.joystickSprite.position = CGPointMake(-sin(angle)*RADIUS, -cos(angle)*RADIUS);
        }
        [self.delegate joystickVectorChange:CGVectorMake(self.joystickSprite.position.x*self.joystickScale,
                                                         self.joystickSprite.position.y*self.joystickScale)];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.delegate joystickEnd];
    [self.joystickSprite runAction:[SKAction moveTo:CGPointZero duration:0.5]];
}
@end
