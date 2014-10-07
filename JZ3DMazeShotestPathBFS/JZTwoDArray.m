//
//  JZTwoDArray.m
//  JZMazeBot3D
//
//  Created by jihong zhang on 8/26/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import "JZTwoDArray.h"


@implementation JZTwoDArray


-(id) initWithRows: (size_t) rows cols: (size_t) cols
{
    self = [super init];
    if (self != nil)
    {
        self.numRows = rows;
        self.numCols = cols;
        self.backingStore = [[NSMutableArray alloc] initWithCapacity:rows * cols ];
    }
    return self;
}

-(id) initWithRows: (size_t) rows cols: (size_t) cols values: (NSArray*) values
{
    self = [super init];
    if (self != nil)
    {
        if (rows * cols != [values count]) 
        {
            // the values are not the right size for the array
            return nil;
        }
        self.numRows = rows;
        self.numCols = cols;
        self.backingStore = [values copy];
    }
    return self;
}

-(id) initWithRows: (size_t) rows cols: (size_t) cols object:(NSObject*)obj
{
    self = [super init];
    if (self != nil)
    {
        self.numRows = rows;
        self.numCols = cols;
        self.backingStore = [[NSMutableArray alloc] initWithCapacity:rows * cols];
        for (int i=0; i< rows*cols; i++){
            [self.backingStore addObject:obj];
        }
    }
    return self;
}

-(void) replaceObject:(NSObject*)obj atRow: (size_t) row col: (size_t) col
{
    if (col >= self.numCols || row >= self.numRows)
    {
        return;
    }
    size_t index = row * self.numCols + col;
    [self.backingStore  replaceObjectAtIndex:index withObject:obj];
    return;
}


-(id) getObjectAtRow: (size_t) row col: (size_t) col
{
    size_t index = row * self.numCols + col;
    return [self.backingStore objectAtIndex: index];
}

-(void) setObject:(NSObject*)object atRow: (size_t) row col: (size_t) col
{
    if (col >= self.numCols)
    {
        // raise same exception as index out of bounds on NSArray.
        // Don't need to check the row because if it's too big the
        // retrieval from the backing store will throw an exception.
    }
    size_t index = row * self.numCols + col;
    [self.backingStore insertObject:object atIndex:index];
    return;
}



@end
