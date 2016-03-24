//
//  Tile.h
//  Wheel
//
//  Created by edguo on 2014-04-13.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum{
    RectangleTileActive,
    RectangleTileRest,
    TriangleLeftTile,
    TriangleRightTile
}TileType;

@interface Tile : SKSpriteNode

-(id)initWithTexture:(SKTexture *)texture PhysicsBodyType:(TileType)bodyType;
+(instancetype)tileWithTexture:(SKTexture *)texture PhysicsBodyType:(TileType)bodyType;

-(BOOL)loseHealth:(uint8_t)health;
-(void)setupTileWithTexture:(SKTexture *)texture PhysicsBodyType:(TileType)bodyType;

@property(nonatomic) BOOL destoryable;
@property(nonatomic) uint8_t health;
@end
