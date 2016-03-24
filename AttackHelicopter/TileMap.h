//
//  TileMap.h
//  Wheel
//
//  Created by on 2014-04-12.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Tile.h"

#define TILE_WIDTH 30.0

@interface TileMap : SKNode
-(id)initMapWithScreenSize:(CGSize)size File:(NSString*)name;
-(BOOL)expandTilesToX:(CGFloat)x;
-(void)removeTilesToX:(CGFloat)x;
-(void)destoryTile:(Tile*)tile;

@property(nonatomic) NSUInteger loadStartIndex;
@property(nonatomic) NSUInteger loadEndIndex;

@property(nonatomic) CGFloat loadStartX;
@property(nonatomic) CGFloat loadEndX;

@property(nonatomic) NSString* mapFile;
@property(nonatomic) NSMutableArray* rawArray;

@property(nonatomic) SKTexture *rectTextureS;
@property(nonatomic) SKTexture *rectTextureB;

@property(nonatomic) SKTexture *rectTextureL;
@property(nonatomic) SKTexture *rectTextureR;

@property(nonatomic) SKTexture *triTextureL;
@property(nonatomic) SKTexture *triTextureR;
@end
