//
//  JZShotestPathBFS.m
//  JZMazeBot3D
//
//  Created by jihong zhang on 8/30/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import "JZShotestPathBFS.h"
#import "JZPathNodeQueue.h"

#define numDirections 6
const char dx[numDirections] = {0,0,-1,1};
const char dy[numDirections] = {-1,1,0,0};
const char direction[numDirections] = {'W','E','N','S','U','D'};

@implementation JZShotestPathBFS


-(id)initWithLayers:(int)layers rows:(int)rows col:(int)cols data:(NSMutableDictionary*)propertyContainer
{
    self = [super init];
    if (self != nil)
    {
        self.layers = layers;
        self.rows = rows;
        self.cols = cols;
        self.propertyContainer = propertyContainer;
    }
    return self;
}

-(BOOL)isNextStepMovableForPoint:(JZMazePoint*)currentPoint layer:(int*)currentLayer inDirection:(int)direction nextX:(int*)nextX nextY:(int*)nextY
{
    if( direction == 4 ){  //up one layer
        if( *currentLayer >= self.layers-1 ){
            return false;
        }
        (*currentLayer)++; //same x,y, but layer changed
    }else if( direction == 5 ){ //down one layer
        if( *currentLayer <= 0 ){
            return false;
        }
        (*currentLayer)--; //same x,y, but layer changed
    }else{  // in the same layer, x, y changed
        *nextX = currentPoint.x + dx[direction];
        *nextY = currentPoint.y + dy[direction];
        if( *nextX < 0 || *nextX >= self.rows ||
            *nextY < 0 || *nextY >= self.cols ){
            return false;
        }
    }

    NSMutableString *block = [NSMutableString stringWithFormat:@"block%d", *currentLayer];
    
    JZTwoDArray *tmp = [self.propertyContainer objectForKey:block];
    BOOL tried = [[tmp getObjectAtRow:*nextX col:*nextY] boolValue];
    
    return (!tried);
}

-(void)generateShotestPathFromQueue:(JZPathNodeQueue*)queue 
{
    NSMutableArray *pathPoints = [self.propertyContainer objectForKey:@"pathPoints"];
    NSMutableArray *pathDirections = [self.propertyContainer objectForKey:@"pathDirections"];
    
    int count = [queue getCount];
    int nodeIndex = count-1;
    
    int parent = -1;
    do{
        JZPathNode *node = [queue getNodeAtIndex:nodeIndex];
        nodeIndex = parent = node.parentNode;
        [pathPoints addObject:node.point];
        int direction = node.direction;
        char directionName;
        switch(direction){
            case 0:
                directionName = 'W';
                break;
            case 1:
                directionName = 'E';
                break;
            case 2:
                directionName = 'N';
                break;
            case 3:
                directionName = 'S';
                break;
            case 4:
                directionName = 'U';
                break;
            case 5:
                directionName = 'D';
                break;
        }
        [pathDirections addObject:[NSNumber numberWithChar:directionName]];
    }while(parent != -1);
}

-(BOOL)hasPathFromStartPoint:(JZMazePoint*)start toEndPoint:(JZMazePoint*)end
{
    int num = self.rows * self.cols * self.layers / 2;
    //using array to simulate the Q
    JZPathNodeQueue *queue = [[JZPathNodeQueue alloc] initWithCapacity:num];
    
    JZPathNode *startNode = [[JZPathNode alloc] initWithMazePoint:start direction:-1 parent: -1];
    
    //push the first step in Q and mark it's tried
    [queue pushNodeToQ:startNode];
    NSMutableString *block = [NSMutableString stringWithFormat:@"block%d", start.layer];
    [[self.propertyContainer objectForKey:block] replaceObject:[NSNumber numberWithBool:YES] atRow:start.x col:start.y];
    int layerInBFS = 0;
    while(!queue.isQueueEmpty){
        JZPathNode *currentNode = [queue popupNodeFromQ];
        JZMazePoint *currentPoint = currentNode.point;
        
        for(int direction = 0; direction < numDirections; ++direction){
            //need to get the current lay here, because the lay could
            //change in isNextStepMovable(...) call
            int layer = currentNode.point.layer;
            int nextX = currentPoint.x;
            int nextY = currentPoint.y;
            //check if the next step movable
            if([self isNextStepMovableForPoint:currentPoint layer:&layer inDirection:direction nextX:&nextX nextY:&nextY]){
                JZMazePoint *nextPoint = [[JZMazePoint alloc] initWithx:nextX y:nextY layer:layer];
                //check if the next step is the destination
                if([nextPoint isSameAs:end]){
                    JZPathNode *endNode = [[JZPathNode alloc] initWithMazePoint:end direction:direction parent:layerInBFS];
                    [queue pushNodeToQ:endNode]; //push the last step to Q
                    [self generateShotestPathFromQueue:queue];
                    return YES;
                }
                //mark this step tried
                NSMutableString *block = [NSMutableString stringWithFormat:@"block%d", layer];
                [[self.propertyContainer objectForKey:block] replaceObject:[NSNumber numberWithBool:YES] atRow:nextX  col:nextY];
            
                JZPathNode *triedNode = [[JZPathNode alloc] initWithMazePoint:nextPoint direction:direction parent:layerInBFS];
                [queue pushNodeToQ:triedNode]; //push next step to Q
            }
        }
        ++layerInBFS;
    }
    return NO;
}


@end
