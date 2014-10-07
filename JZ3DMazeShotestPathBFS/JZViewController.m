//
//  JZViewController.m
//  JZ3DMazeShotestPathBFS
//
//  Created by jihong zhang on 9/2/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import "JZViewController.h"
#import "JZCheckBox.h"
#import "JZTwoDArray.h"
#import "JZMazePoint.h"
#import "JZShotestPathBFS.h"

#define  MAX_LAYER_ALLOWED   4


@interface JZViewController ()

@end

@implementation JZViewController

-(void)viewDidLayoutSubviews
{
    self.scrollViewBlock0.contentSize = CGSizeMake(300, 300);
    self.scrollViewBlock1.contentSize = CGSizeMake(300, 300);
    self.scrollViewBlock2.contentSize = CGSizeMake(300, 300);
    self.scrollViewBlock3.contentSize = CGSizeMake(300, 300);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.propertyContainer = [[NSMutableDictionary alloc] init];
    self.pathPoints = [[NSMutableArray alloc] init];
    self.pathDirections = [[NSMutableArray alloc] init];

    [self.propertyContainer  setObject:self.scrollViewBlock0 forKey:@"scrollViewBlock0"];
    [self.propertyContainer  setObject:self.scrollViewBlock1 forKey:@"scrollViewBlock1"];
    [self.propertyContainer  setObject:self.scrollViewBlock2 forKey:@"scrollViewBlock2"];
    [self.propertyContainer  setObject:self.scrollViewBlock3 forKey:@"scrollViewBlock3"];
    [self.propertyContainer  setObject:self.pathPoints forKey:@"pathPoints"];
    [self.propertyContainer  setObject:self.pathDirections forKey:@"pathDirections"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonGetDefaultMaze:(id)sender {
    
    //free old checkBox if there is any in the subview
    for(int i = 0; i < MAX_LAYER_ALLOWED; i++){
        NSMutableString *scrollViewBlock = [NSMutableString stringWithFormat:@"scrollViewBlock%d", i];
        NSArray *subviews = [[self.propertyContainer objectForKey:scrollViewBlock] subviews];
        for (UIView *subView in subviews) {
            if ([subView isKindOfClass:[JZCheckBox class]]) {
                [subView removeFromSuperview];
            }
        }
    }
    
    self.rows = self.textFieldRow.text.integerValue;
    self.cols = self.textFieldCols.text.integerValue;
    self.layer = self.textFieldTotalLayer.text.integerValue;
    
    self.block0 = [[JZTwoDArray alloc] initWithRows:self.rows cols:self.cols object:[NSNumber numberWithBool:YES]];
    self.block1 = [[JZTwoDArray alloc] initWithRows:self.rows cols:self.cols object:[NSNumber numberWithBool:YES]];
    self.block2 = [[JZTwoDArray alloc] initWithRows:self.rows cols:self.cols object:[NSNumber numberWithBool:YES]];
    self.block3 = [[JZTwoDArray alloc] initWithRows:self.rows cols:self.cols object:[NSNumber numberWithBool:YES]];
    
    self.checkBoxBlock0 = [[JZTwoDArray alloc] initWithRows:self.rows cols:self.cols];
    self.checkBoxBlock1 = [[JZTwoDArray alloc] initWithRows:self.rows cols:self.cols];
    self.checkBoxBlock2 = [[JZTwoDArray alloc] initWithRows:self.rows cols:self.cols];
    self.checkBoxBlock3 = [[JZTwoDArray alloc] initWithRows:self.rows cols:self.cols];
    
    [self.propertyContainer  setObject:self.block0 forKey:@"block0"];
    [self.propertyContainer  setObject:self.block1 forKey:@"block1"];
    [self.propertyContainer  setObject:self.block2 forKey:@"block2"];
    [self.propertyContainer  setObject:self.block3 forKey:@"block3"];
    
    [self.propertyContainer  setObject:self.checkBoxBlock0 forKey:@"checkBoxBlock0"];
    [self.propertyContainer  setObject:self.checkBoxBlock1 forKey:@"checkBoxBlock1"];
    [self.propertyContainer  setObject:self.checkBoxBlock2 forKey:@"checkBoxBlock2"];
    [self.propertyContainer  setObject:self.checkBoxBlock3 forKey:@"checkBoxBlock3"];
    
    
    for(int i = 0; i < self.layer; i++){
        NSMutableString *scrollViewBlock = [NSMutableString stringWithFormat:@"scrollViewBlock%d", i];
        NSMutableString *block = [NSMutableString stringWithFormat:@"block%d", i];
        NSMutableString *checkBoxBlock = [NSMutableString stringWithFormat:@"checkBoxBlock%d", i];
        [self generateInitDataForUIBlock:(UIScrollView*)[self.propertyContainer objectForKey:scrollViewBlock] withName:block andCheckBoxHolder:[self.propertyContainer objectForKey:checkBoxBlock] andDataBlock:[self.propertyContainer objectForKey:block]];
    }
    
}

- (IBAction)buttonGetSolution:(id)sender {
    self.startLayer = self.textFieldStartZ.text.integerValue;
    self.endLayer = self.textFieldEndZ.text.integerValue;
    self.endX = self.textFieldEndX.text.integerValue;
    self.endY = self.textFieldEndY.text.integerValue;
    
    if([self.pathPoints count]){
        [self.pathPoints removeAllObjects];
    }
    if([self.pathDirections count]){
        [self.pathDirections removeAllObjects];
    }
    
    BOOL hasPath = [self getEscapePath];
    if(hasPath){
        JZCheckBox *checkBox;
        for (int k = [self.pathPoints count]-1; k >= 0; k--) {
            JZMazePoint *point = [self.pathPoints objectAtIndex: k];
            char direction = [[self.pathDirections objectAtIndex: k] charValue];
            NSString *imageName = [[NSString alloc] initWithFormat:@"%c",  direction];
            
            switch(point.layer){
                case 0:
                    checkBox = [self.checkBoxBlock0 getObjectAtRow:point.x col:point.y];
                    checkBox.offImage = [UIImage imageNamed:imageName];
                    [checkBox setChecked:FALSE];
                    break;
                case 1:
                    checkBox = [self.checkBoxBlock1 getObjectAtRow:point.x col:point.y];
                    checkBox.offImage = [UIImage imageNamed:imageName];
                    [checkBox setChecked:FALSE];
                    break;
                case 2:
                    checkBox = [self.checkBoxBlock2 getObjectAtRow:point.x col:point.y];
                    checkBox.offImage = [UIImage imageNamed:imageName];
                    [checkBox setChecked:FALSE];
                    break;
                case 3:
                    checkBox = [self.checkBoxBlock3 getObjectAtRow:point.x col:point.y];
                    checkBox.offImage = [UIImage imageNamed:imageName];
                    [checkBox setChecked:FALSE];
                    break;
            }
        }
        //set starting point
        NSMutableString *checkBoxBlock = [NSMutableString stringWithFormat:@"checkBoxBlock%d", self.startLayer-1];
        checkBox = [[self.propertyContainer objectForKey:checkBoxBlock] getObjectAtRow:0 col:0];
        checkBox.offImage = [UIImage imageNamed:@"gold-star.jpg"];
        [checkBox setChecked:FALSE];
        
        checkBoxBlock = [NSMutableString stringWithFormat:@"checkBoxBlock%d", self.endLayer-1];
        checkBox = [[self.propertyContainer objectForKey:checkBoxBlock] getObjectAtRow:self.endX-1 col:self.endY-1];
        checkBox.offImage = [UIImage imageNamed:@"endPoint.jpg"];
        
        [checkBox setChecked:FALSE];
        
        [self.scrollViewBlock0  setNeedsDisplay];
    }
    else{
        //popup alarm
        NSLog(@"No solution");
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Not Escapable" message:@"Please edit the Maze and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 11;
        [alert show];
        
        [self resetBlockValueWithMaze];
        return;

    }

}

-(void)resetBlockValueWithMaze
{
    for(int i = 0; i < self.layer; i++){
        NSMutableString *blockName = [NSMutableString stringWithFormat:@"block%d", i];
        NSMutableString *checkBoxBlockName = [NSMutableString stringWithFormat:@"checkBoxBlock%d", i];
        JZTwoDArray* checkBoxBlock = [self.propertyContainer objectForKey:checkBoxBlockName];
        JZTwoDArray* block = [self.propertyContainer objectForKey:blockName];
        
        
        for(int j=0; j<self.rows; j++){
            for(int k=0; k<self.cols; k++){
                Boolean state = [[checkBoxBlock getObjectAtRow:j col:k] isChecked];
                [block replaceObject:[NSNumber numberWithBool:state] atRow:j col:k];
            }
        }
         
    }
}

-(BOOL)getEscapePath
{
    //block layer start from 0 to (self.layer - 1)
    JZMazePoint *start = [[JZMazePoint alloc] initWithx:0 y:0 layer:self.startLayer-1];
    JZMazePoint *end = [[JZMazePoint alloc] initWithx:self.endX-1 y:self.endY-1 layer:self.endLayer-1];
    
    JZShotestPathBFS *pathBFS = [[JZShotestPathBFS alloc] initWithLayers:self.layer rows:self.rows col:self.cols data:self.propertyContainer];
    
    return [pathBFS hasPathFromStartPoint:start toEndPoint:end ];
    
}


-(void)displayDataForUIBlock:(UIScrollView*)uiBlock withBlockData:(JZTwoDArray*)blockName
{
    NSArray *subviews = [uiBlock subviews];
    for (UIView *subView in subviews) {
        if ([subView isKindOfClass:[JZCheckBox class]]) {
            JZCheckBox *checkBox = (JZCheckBox*)subView;
            NSNumber *num = (NSNumber*)[blockName getObjectAtRow:checkBox.index col:checkBox.indexY];
            if([num integerValue]==0 && checkBox.isChecked){
                [checkBox setChecked:0];
            }else if([num integerValue]==1 && !checkBox.isChecked){
                [checkBox setChecked:1];
            }
        }
    }
}

-(void)generateInitDataForUIBlock:(UIScrollView*)uiBlock withName:(NSString*)blockName andCheckBoxHolder:(JZTwoDArray*)checkBoxBlock andDataBlock:(JZTwoDArray*)block
{
    CGFloat checkWidth = myCheckboxImageWidth;
    CGFloat checkHeight = myCheckboxImageHeight;
    CGFloat checkX;
    CGFloat checkY;
    for(int row = 0; row < self.rows; row++){
        checkY = myMargin + row * checkHeight;
        for(int col = 0; col < self.cols; col++){
            checkX = myMargin + col * checkWidth;
            CGRect frame = CGRectMake(checkX, checkY, checkWidth, checkHeight);
            JZCheckBox *checkBox = [[JZCheckBox alloc] initWithKey:blockName indexX:row indexY:col frame:frame state: YES];
            checkBox.delegate = self;
            [uiBlock addSubview:checkBox];
            [checkBoxBlock setObject:checkBox atRow:row col:col];
        }
    }
}

#pragma mark - JZCheckBox delegate
-(void) onCheckBoxChange:(JZCheckBox *)checkBox isChecked:(BOOL)isChecked
{
    [[self.propertyContainer objectForKey:checkBox.key] replaceObject:[NSNumber numberWithBool:isChecked] atRow:checkBox.index  col:checkBox.indexY];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField.text intValue] <= 0){
        textField.text = @"1";
    }else{
        if(textField.tag == 3){
            if([textField.text intValue] > 4){
                textField.text = [NSString stringWithFormat:@"%d",4];
            }
        }
    }
    
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)endRowInputCheck:(id)sender {
    if(self.textFieldEndX.text.intValue > self.textFieldRow.text.intValue)
        self.textFieldEndX.text = self.textFieldRow.text;
}
 
- (IBAction)endColInputCheck:(id)sender {
    if(self.textFieldEndY.text.intValue > self.textFieldCols.text.intValue)
        self.textFieldEndY.text = self.textFieldCols.text;
}

- (IBAction)endLayerInputCheck:(id)sender {
    if(self.textFieldEndZ.text.intValue > self.textFieldTotalLayer.text.intValue)
        self.textFieldEndZ.text = self.textFieldTotalLayer.text;
}

- (IBAction)startLayerInputCheck:(id)sender {
    if(self.textFieldStartZ.text.intValue > self.textFieldTotalLayer.text.intValue)
        self.textFieldStartZ.text = self.textFieldTotalLayer.text;
}


@end
