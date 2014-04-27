//
//  AmmoDisplayer.m
//  Wheel
//
//  Created by edguo on 2014-04-21.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "AmmoDisplayer.h"

@implementation AmmoDisplayer

-(id)initDisplayerWithCannon:(Cannon*)cannon{
    if (self = [super initWithFontNamed:@"Futura-Medium"]) {
        self.userInteractionEnabled = YES;
        self.cannon = cannon;
        cannon.delegate = self;
        self.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)cannon.ammo,(unsigned long)cannon.maxAmmo];
        self.fontSize = 10;
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.cannon startReload];
}


-(void)AmmoDidChange{
    if (self.cannon.reloading) {
        self.text = [NSString stringWithFormat:@"Reloading:%.1f%@",(CGFloat)self.cannon.ammo/self.cannon.maxAmmo*100.0,@"%"];

    } else {
        self.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)self.cannon.ammo,(unsigned long)self.cannon.maxAmmo];
    }
}

-(void)cannonStartLoad{
    self.text = @"Reloading";
}

-(void)cannonFinishedLoad{
    self.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)self.cannon.ammo,(unsigned long)self.cannon.maxAmmo];
}
@end
