//
//  JZ2DArray.h
//  JZMazeBot3D
//
//  Created by jihong zhang on 8/26/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZTwoDArray : NSObject

@property (retain) NSMutableArray* backingStore;
@property (nonatomic) size_t numRows;
@property (nonatomic) size_t numCols;


// values is a linear array in row major order
-(id) initWithRows: (size_t) rows cols: (size_t) cols;
-(id) initWithRows: (size_t) rows cols: (size_t) cols object:(NSObject*)obj;
-(id) initWithRows: (size_t) rows cols: (size_t) cols values: (NSArray*) values;

-(id) getObjectAtRow: (size_t) row col: (size_t) col;
-(void) setObject:(NSObject*)object atRow: (size_t) row col: (size_t) col;
-(void) replaceObject:(NSObject*)obj atRow: (size_t) row col: (size_t) col;


@end
