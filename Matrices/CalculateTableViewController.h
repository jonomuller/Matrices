//
//  CalculateTableViewController.h
//  Test
//
//  Created by Jono Muller on 12/01/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Matrix.h"

@interface CalculateTableViewController : UITableViewController <UIAlertViewDelegate>
{
    Matrix *firstMatrix, *secondMatrix, *finalMatrix;
    NSArray *allLabels, *finalLabels, *firstLabels, *secondLabels, *firstRow, *secondRow, *thirdRow, *firstRow2, *secondRow2, *thirdRow2, *finalRow1, *finalRow2, *finalRow3, *finalRows, *firstRows, *secondRows, *detLabels;
    NSNumberFormatter *formatter;
}

@property (strong, nonatomic) NSMutableArray *headers, *matrices;

@property (nonatomic) NSInteger operationIndex, firstMatrixIndex, secondMatrixIndex, currentRow1, currentColumn1, currentRow2, currentColumn2, currentPos, finalRow, finalColumn;

@property (strong, nonatomic) NSMutableAttributedString *calculationString, *determinantAnswer;

@property (strong, nonatomic) IBOutlet UIImageView *leftBracket1, *leftBracket2, *leftBracket3, *rightBracket1, *rightBracket2, *rightBracket3, *detBracketLeft, *detBracketRight;

@property (strong, nonatomic) IBOutlet UILabel *label1, *label2, *label3, *label4, *label5, *label6, *label7, *label8, *label9, *label10, *label11, *label12, *label13, *label14, *label15, *label16, *label17, *label18, *opLabel, *label19, *label20, *label21, *label22, *label23, *label24, *label25, *label26, *label27, *detLabel1, *detLabel2, *detLabel3, *detLabel4, *detCalculation;

- (IBAction)nextStep:(id)sender;
- (void)performAdditionOrSubtraction;
- (void)performMulitplcation;
- (void)performDeterminant;
- (void)performInverse;
- (void)performAlgebra;

@end
