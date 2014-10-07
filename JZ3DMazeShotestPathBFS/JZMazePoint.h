//
//  JZMazePoint.h
//  JZMazeBot3D
//
//  Created by jihong zhang on 8/30/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZMazePoint : NSObject

@property (nonatomic) int x;
@property (nonatomic) int y;
@property (nonatomic) int layer;


-(id)initWithx:(int)x y:(int)y layer:(int)layer;

-(BOOL)isSameAs:(JZMazePoint*)p2;


@end
