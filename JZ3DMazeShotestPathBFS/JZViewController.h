//
//  JZViewController.h
//  JZ3DMazeShotestPathBFS
//
//  Created by jihong zhang on 9/2/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZCheckBox.h"
#import "JZTwoDArray.h"


@interface JZViewController : UIViewController <UITextFieldDelegate, CheckBoxDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldRow;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCols;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTotalLayer;
@property (weak, nonatomic) IBOutlet UITextField *textFieldStartZ;

@property (weak, nonatomic) IBOutlet UITextField *textFieldEndX;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEndY;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEndZ;

- (IBAction)buttonGetDefaultMaze:(id)sender;
- (IBAction)buttonGetSolution:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBlock0;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBlock1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBlock2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBlock3;


- (IBAction)endRowInputCheck:(id)sender;
- (IBAction)endColInputCheck:(id)sender;
- (IBAction)endLayerInputCheck:(id)sender;
- (IBAction)startLayerInputCheck:(id)sender;



@property (nonatomic) int rows;
@property (nonatomic) int cols;
@property (nonatomic) int layer;
@property (nonatomic) JZTwoDArray *block0;
@property (nonatomic) JZTwoDArray *block1;
@property (nonatomic) JZTwoDArray *block2;
@property (nonatomic) JZTwoDArray *block3;

@property (nonatomic) JZTwoDArray *checkBoxBlock0;
@property (nonatomic) JZTwoDArray *checkBoxBlock1;
@property (nonatomic) JZTwoDArray *checkBoxBlock2;
@property (nonatomic) JZTwoDArray *checkBoxBlock3;

// two dimentions array: row0: points, row1: directions
@property (nonatomic) NSMutableArray *pathPoints;
@property (nonatomic) NSMutableArray *pathDirections;


@property (nonatomic) int  totalSteps;

@property (nonatomic) NSMutableDictionary *propertyContainer;

@property (nonatomic) int startLayer;
@property (nonatomic) int endLayer;
@property (nonatomic) int endX;
@property (nonatomic) int endY;


@end
