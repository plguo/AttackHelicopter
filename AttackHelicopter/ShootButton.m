//
//  ShootButton.m
//  Wheel
//
//  Created by edguo on 2014-04-18.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "ShootButton.h"

@implementation ShootButton
-(id)initShootButton{
    if (self = [super initWithImageNamed:@"CannonButtonImage"]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (!self.trackingTouch && self.delegate) {
        self.trackingTouch = [touches anyObject];
        
        SKAction *shoot = [SKAction performSelector:@selector(shoot) onTarget:self];
        SKAction *wait = [SKAction waitForDuration:[self.delegate cannonWaitInterval]];
        SKAction *sequence = [SKAction sequence:@[shoot,wait]];
        [self runAction:[SKAction repeatActionForever:sequence]];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (self.trackingTouch) {
        if ([touches containsObject:self.trackingTouch]) {
            self.trackingTouch = nil;
            [self removeAllActions];
        }
    }
}

-(void)shoot{
    if (self.delegate) {
        if (![self.delegate shootBullet]) {
            [self removeAllActions];
        }
    }
}
@end
