//
//  RocketButton.m
//  Wheel
//
//  Created by edguo on 2014-04-18.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "RocketButton.h"

@implementation RocketButton
-(id)initButton{
    if (self = [super initWithImageNamed:@"RocketButtonImage"]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (!self.trackingTouch && self.delegate) {
        self.trackingTouch = [touches anyObject];
        
        SKAction* launch = [SKAction performSelector:@selector(delegateLaunchRocket) onTarget:self];
        SKAction* wait = [SKAction waitForDuration:[self.delegate rocketWaitInterval] withRange:0.1];
        SKAction* sequence = [SKAction sequence:@[launch,wait]];
        [self runAction:[SKAction repeatActionForever:sequence]];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (self.trackingTouch) {
        if ([touches containsObject:self.trackingTouch]) {
            self.trackingTouch = nil;
            [self removeAllActions];
            if (self.delegate) {
                [self.delegate stopLaunchRocket];
            }
        }
    }
}

-(void)delegateLaunchRocket{
    if (self.delegate) {
        if (![self.delegate launchRocket]) {
            [self removeAllActions];
            self.trackingTouch = nil;
        }
    }
    
}
         
@end
