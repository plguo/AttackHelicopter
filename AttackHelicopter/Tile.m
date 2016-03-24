//
//  Tile.m
//  Wheel
//
//  Created by edguo on 2014-04-13.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "Tile.h"
#import "CategoryBitMaskOpition.h"

@implementation Tile
-(id)initWithTexture:(SKTexture *)texture PhysicsBodyType:(TileType)bodyType{
    if (self = [super initWithTexture:texture]) {
        self.zPosition = 2.0;
        self.destoryable = YES;
        self.health = 20;
        if (bodyType == TriangleLeftTile) {
            CGFloat offsetX = self.frame.size.width * self.anchorPoint.x;
            CGFloat offsetY = self.frame.size.height * self.anchorPoint.y;
            
            CGMutablePathRef path = CGPathCreateMutable();
            
            CGPathMoveToPoint(path, NULL, 30 - offsetX, 30 - offsetY);
            CGPathAddLineToPoint(path, NULL, 0 - offsetX, 0 - offsetY);
            CGPathAddLineToPoint(path, NULL, 30 - offsetX, 0 - offsetY);
            
            CGPathCloseSubpath(path);
            
            self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
            CGPathRelease(path);
            
        } else if (bodyType == TriangleRightTile){
            CGFloat offsetX = self.frame.size.width * self.anchorPoint.x;
            CGFloat offsetY = self.frame.size.height * self.anchorPoint.y;
            
            CGMutablePathRef path = CGPathCreateMutable();
            
            CGPathMoveToPoint(path, NULL, 0 - offsetX, 30 - offsetY);
            CGPathAddLineToPoint(path, NULL, 30 - offsetX, 0 - offsetY);
            CGPathAddLineToPoint(path, NULL, 0 - offsetX, 0 - offsetY);
            
            CGPathCloseSubpath(path);
            
            self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
            
            
            CGPathRelease(path);
        
        } else if (bodyType == RectangleTileActive) {
            self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        } else {
            return self;
        }
        
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = CategoryTile;
        self.physicsBody.contactTestBitMask = CategoryHelicopter | CategoryFriendWeapon;
    }
    return self;
}

-(void)setupTileWithTexture:(SKTexture *)texture PhysicsBodyType:(TileType)bodyType{
    self.texture = texture;
    if (bodyType == TriangleLeftTile) {
        CGFloat offsetX = self.frame.size.width * self.anchorPoint.x;
        CGFloat offsetY = self.frame.size.height * self.anchorPoint.y;
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 30 - offsetX, 30 - offsetY);
        CGPathAddLineToPoint(path, NULL, 0 - offsetX, 0 - offsetY);
        CGPathAddLineToPoint(path, NULL, 30 - offsetX, 0 - offsetY);
        
        CGPathCloseSubpath(path);
        
        self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
        CGPathRelease(path);
        
    } else if (bodyType == TriangleRightTile){
        CGFloat offsetX = self.frame.size.width * self.anchorPoint.x;
        CGFloat offsetY = self.frame.size.height * self.anchorPoint.y;
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 0 - offsetX, 30 - offsetY);
        CGPathAddLineToPoint(path, NULL, 30 - offsetX, 0 - offsetY);
        CGPathAddLineToPoint(path, NULL, 0 - offsetX, 0 - offsetY);
        
        CGPathCloseSubpath(path);
        
        self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
        
        
        CGPathRelease(path);
    } else if (bodyType == RectangleTileActive) {
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    } else {
        return;
    }
    
    self.physicsBody.dynamic = NO;
    self.physicsBody.friction = 1.0;
    self.physicsBody.categoryBitMask = CategoryTile;
    self.physicsBody.contactTestBitMask = CategoryFriendWeapon;
}

-(BOOL)loseHealth:(uint8_t)health{
    if (self.destoryable) {
        if (health<self.health) {
            self.health -= health;
            return NO;
        }else{
            return YES;
        }
    }
    return NO;
}

+(instancetype)tileWithTexture:(SKTexture *)texture PhysicsBodyType:(TileType)bodyType{
    return [[Tile alloc] initWithTexture:texture PhysicsBodyType:bodyType];
}
@end
