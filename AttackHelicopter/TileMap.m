//
//  TileMap.m
//  Wheel
//
//  Created by edguo on 2014-04-12.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "TileMap.h"


@implementation TileMap{
    CGSize screenSize;
}
-(id)initMapWithScreenSize:(CGSize)size File:(NSString*)name{
    if (self = [super init]) {
        //[self setupTiles:60];
        
        screenSize = size;
        self.mapFile = name;
        
        self.rectTextureS = [SKTexture textureWithImageNamed:@"rectBlockStk"];
        self.rectTextureB = [SKTexture textureWithImageNamed:@"rectBlockBtk"];
        
        self.rectTextureL = [SKTexture textureWithImageNamed:@"rectBlockBtk"];
        self.rectTextureR = [SKTexture textureWithImageNamed:@"rectBlockBtk"];
        
        self.triTextureL = [SKTexture textureWithImageNamed:@"triBlockLtk"];
        self.triTextureR = [SKTexture textureWithImageNamed:@"triBlockRtk"];
        
        self.loadStartX = 0.0;
        self.loadEndX = 0.0;
        
        self.loadStartIndex = 0;
        self.loadEndIndex = 0;
        
        [self preReadMap];
    }
    return self;
}

-(BOOL)expandTilesToX:(CGFloat)x{
    if (self.loadEndIndex == [self.rawArray count]) {
        return NO;
    }
    while (self.loadEndX < x && self.loadEndIndex < [self.rawArray count]) {
        [self setupTilesColumn:self.loadEndIndex];
        self.loadEndIndex ++;
        self.loadEndX += TILE_WIDTH;
    }
    return YES;
}

-(void)removeTilesToX:(CGFloat)x{
    while (self.loadStartX < x) {
        [self removeTilesColumn:self.loadStartIndex];
        self.loadStartIndex ++;
        self.loadStartX += TILE_WIDTH;
    }

}

-(void)preReadMap{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"TestRange" ofType:@"map"];
    NSString* fileData = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSArray *lineArray = [fileData componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    if (!lineArray || [lineArray count] < 1) return;
    
    NSMutableArray *processedArray = [NSMutableArray arrayWithCapacity:[lineArray count]];
    for (NSUInteger i = 0; i < [lineArray count]; i++) {
        NSString* string = [lineArray objectAtIndex:i];
        NSString* subString = [string substringFromIndex:0];
        
        NSNumber* number = [NSNumber numberWithUnsignedShort:[subString intValue]];
        [processedArray setObject:number atIndexedSubscript:i];
    }
    
    self.rawArray = processedArray;
}

-(void)removeTilesColumn:(NSUInteger)column{
    CGFloat posY = TILE_WIDTH/2;
    CGFloat posX = TILE_WIDTH*column + posY;
    SKNode* node;
    
    while (YES) {
        node = [self nodeAtPoint:CGPointMake(posX, posY)];
        if ([node isEqual:self]) {
            break;
        }else{
            [node removeFromParent];
            posY += TILE_WIDTH;
        }
    }
}

-(void)setupTilesColumn:(NSUInteger)column{
    BOOL flat = YES,slopeLeft = NO;
    
    NSNumber* numberCurrent = [self.rawArray objectAtIndex:column];
    unsigned short currentHeight = [numberCurrent unsignedShortValue];
    
    if (column != 0) {
        NSNumber* numberPast = [self.rawArray objectAtIndex:column-1];
        unsigned short pastHeight = [numberPast unsignedShortValue];
        
        if (currentHeight>pastHeight) {
            flat = NO;
            slopeLeft = YES;
        }
    }
    
    if (column + 1 < [self.rawArray count]) {
        NSNumber* numberNext = [self.rawArray objectAtIndex:column+1];
        unsigned short nextHeight = [numberNext unsignedShortValue];
        
        if (currentHeight>nextHeight) {
            flat = NO;
            slopeLeft = NO;
        }
    }
    
    
    CGFloat posY = TILE_WIDTH/2;
    CGFloat posX = TILE_WIDTH*column + posY;
    
    BOOL willSetBottomTile = YES;
    if(flat){
        for (int i = 1; i < currentHeight; i++) {
            Tile* rectTile = [Tile tileWithTexture:self.rectTextureB PhysicsBodyType:RectangleTileRest];
            rectTile.position = CGPointMake(posX, posY);
            
            if (willSetBottomTile) {
                rectTile.destoryable = NO;
                willSetBottomTile = NO;
            }
            
            [self addChild:rectTile];
            
            
            posY += TILE_WIDTH;
        }
        
        Tile* surfaceTile = [Tile tileWithTexture:self.rectTextureS PhysicsBodyType:RectangleTileActive];
        surfaceTile.position = CGPointMake(posX, posY);
        
        if (willSetBottomTile) {
            surfaceTile.destoryable = NO;
        }
        
        [self addChild:surfaceTile];
        
    }else{
        for (int i = 2; i < currentHeight; i++) {
            Tile* rectTile = [Tile tileWithTexture:self.rectTextureB PhysicsBodyType:RectangleTileRest];
            rectTile.position = CGPointMake(posX, posY);
            
            if (willSetBottomTile) {
                rectTile.destoryable = NO;
                willSetBottomTile = NO;
            }
            
            [self addChild:rectTile];
            
            
            posY += TILE_WIDTH;
        }
        
        Tile* cornerTile;
        if (slopeLeft) {
            cornerTile = [Tile tileWithTexture:self.rectTextureL PhysicsBodyType:RectangleTileActive];
        }else{
            cornerTile = [Tile tileWithTexture:self.rectTextureR PhysicsBodyType:RectangleTileActive];
        }
        cornerTile.position = CGPointMake(posX, posY);
        if (willSetBottomTile) {
            cornerTile.destoryable = NO;
        }
        [self addChild:cornerTile];
        posY += TILE_WIDTH;
        
        Tile* triTile;
        if (slopeLeft) {
            triTile = [Tile tileWithTexture:self.triTextureL PhysicsBodyType:TriangleLeftTile];
        }else{
            triTile = [Tile tileWithTexture:self.triTextureR PhysicsBodyType:TriangleRightTile];
        }
        triTile.position = CGPointMake(posX, posY);
        [self addChild:triTile];
        
        
    }

}

-(void)resetupTileAtPosition:(CGPoint)position{
    SKNode* node = [self nodeAtPoint:position];
    if ([node isKindOfClass:[Tile class]]) {
        BOOL left = [self isAnyNodeAtPosition:CGPointMake(position.x-TILE_WIDTH, position.y)];
        BOOL right = [self isAnyNodeAtPosition:CGPointMake(position.x+TILE_WIDTH, position.y)];
        
        BOOL upperLeft = [self isAnyNodeAtPosition:CGPointMake(position.x-TILE_WIDTH, position.y+TILE_WIDTH)];
        BOOL upperRight = [self isAnyNodeAtPosition:CGPointMake(position.x+TILE_WIDTH, position.y+TILE_WIDTH)];
        
        Tile* tile = (Tile *)node;
        if (left && right) {
            if ([self isAnyNodeAtPosition:CGPointMake(position.x, position.y+TILE_WIDTH)]) {
                if (upperLeft && upperRight) {
                    [tile setupTileWithTexture:self.rectTextureB PhysicsBodyType:RectangleTileRest];
                }else if (upperRight){
                    [tile setupTileWithTexture:self.rectTextureL PhysicsBodyType:RectangleTileActive];
                }else if (upperLeft){
                    [tile setupTileWithTexture:self.rectTextureR PhysicsBodyType:RectangleTileActive];
                }
            }else{
                [tile setupTileWithTexture:self.rectTextureS PhysicsBodyType:RectangleTileActive];
            }
        }else if (right){
            [tile setupTileWithTexture:self.triTextureL PhysicsBodyType:TriangleLeftTile];
            SKNode* topNode = [self nodeAtPoint:CGPointMake(position.x, position.y+TILE_WIDTH)];
            if ([topNode isKindOfClass:[Tile class]]) {
                [self destoryTile:(Tile*)topNode];
            }
        }else if (left){
            [tile setupTileWithTexture:self.triTextureR PhysicsBodyType:TriangleRightTile];
            SKNode* topNode = [self nodeAtPoint:CGPointMake(position.x, position.y+TILE_WIDTH)];
            if ([topNode isKindOfClass:[Tile class]]) {
                [self destoryTile:(Tile*)topNode];
            }
        }else{
            [self destoryTile:tile];
        }
    }
}

-(BOOL)isAnyNodeAtPosition:(CGPoint)position{
    return ![self isEqual:[self nodeAtPoint:position]];
}

-(void)destoryTile:(Tile*)tile{
    CGPoint point = tile.position;
    [tile removeFromParent];
    
    [self resetupTileAtPosition:CGPointMake(point.x+TILE_WIDTH, point.y)];
    [self resetupTileAtPosition:CGPointMake(point.x-TILE_WIDTH, point.y)];
    
    [self resetupTileAtPosition:CGPointMake(point.x, point.y-TILE_WIDTH)];
    
    [self resetupTileAtPosition:CGPointMake(point.x-TILE_WIDTH, point.y-TILE_WIDTH)];
    [self resetupTileAtPosition:CGPointMake(point.x+TILE_WIDTH, point.y-TILE_WIDTH)];
}

@end
