//
//  JZShotestPathBFS.h
//  JZMazeBot3D
//
//  Created by jihong zhang on 8/30/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZPathNodeQueue.h"
#import "JZTwoDArray.h"

@interface JZShotestPathBFS : NSObject

@property (nonatomic) BOOL hasPath;

@property (nonatomic) int rows;
@property (nonatomic) int cols;
@property (nonatomic) int layers;

@property (nonatomic, retain) NSMutableDictionary *propertyContainer;


-(id)initWithLayers:(int)layers rows:(int)rows col:(int)cols data:(NSMutableDictionary*)propertyContainer;


-(BOOL)hasPathFromStartPoint:(JZMazePoint*)start toEndPoint:(JZMazePoint*)end;
-(BOOL)isNextStepMovableForPoint:(JZMazePoint*)currentPoint layer:(int*)currentLayer inDirection:(int)direction nextX:(int*)nextX nextY:(int*)nextY;

@end
