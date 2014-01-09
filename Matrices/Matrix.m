//
//  Matrix.m
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import "Matrix.h"

@implementation Matrix

@synthesize row, column, row1, row2, row3, elements, name;

- (void)initialise
{
    row1 = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", nil];
    row2 = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", nil];
    row3 = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", nil];
    
    elements = [[NSMutableArray alloc] initWithObjects:row1, row2, row3, nil];
}

- (Matrix *)copyMatrix
{
    Matrix *copy = [[Matrix alloc] init];
    copy.row = row;
    copy.column = column;
    copy.row1 = row1;
    copy.row2 = row2;
    copy.row3 = row3;
    copy.elements = elements;
    copy.name = name;
    return copy;
}

- (Matrix *)addition:(Matrix *)matrix add:(Matrix *)otherMatrix
{
    Matrix *finalMatrix = [[Matrix alloc] init];
    [finalMatrix initialise];
    if ((matrix.row == otherMatrix.row) && (matrix.column == otherMatrix.column)) {
        finalMatrix.row = matrix.row;
        finalMatrix.column = matrix.column;
        for (int i = 0; i < [matrix.row intValue]; i++) {
            NSInteger finalRow1 = [[matrix.row1 objectAtIndex:i] intValue] + [[otherMatrix.row1 objectAtIndex:i] intValue];
            NSInteger finalRow2 = [[matrix.row2 objectAtIndex:i] intValue] + [[otherMatrix.row2 objectAtIndex:i] intValue];
            NSInteger finalRow3 = [[matrix.row3 objectAtIndex:i] intValue] + [[otherMatrix.row3 objectAtIndex:i] intValue];
            [finalMatrix.row1 replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:finalRow1]];
            [finalMatrix.row2 replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:finalRow2]];
            [finalMatrix.row3 replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:finalRow3]];
        }
    }
    return finalMatrix;
}

- (Matrix *)subtraction:(Matrix *)matrix subtract:(Matrix *)otherMatrix
{
    Matrix *finalMatrix = [[Matrix alloc] init];
    [finalMatrix initialise];
    if ((matrix.row == otherMatrix.row) && (matrix.column == otherMatrix.column)) {
        finalMatrix.row = matrix.row;
        finalMatrix.column = matrix.column;
        for (int i = 0; i < [matrix.row intValue]; i++) {
            NSInteger finalRow1 = [[matrix.row1 objectAtIndex:i] intValue] - [[otherMatrix.row1 objectAtIndex:i] intValue];
            NSInteger finalRow2 = [[matrix.row2 objectAtIndex:i] intValue] - [[otherMatrix.row2 objectAtIndex:i] intValue];
            NSInteger finalRow3 = [[matrix.row3 objectAtIndex:i] intValue] - [[otherMatrix.row3 objectAtIndex:i] intValue];
            [finalMatrix.row1 replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:finalRow1]];
            [finalMatrix.row2 replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:finalRow2]];
            [finalMatrix.row3 replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:finalRow3]];
        }
    }
    return finalMatrix;
}

- (Matrix *)multiplication:(Matrix *)matrix multiply:(Matrix *)otherMatrix
{
    Matrix *finalMatrix = [[Matrix alloc] init];
    [finalMatrix initialise];
    if (matrix.column == otherMatrix.row) {
        finalMatrix.row = matrix.row;
        finalMatrix.column = matrix.column;
        for (int i = 0; i < [matrix.row intValue]; i++) {
            NSInteger finalRow1 = [[matrix.row1 objectAtIndex:i] intValue] * [[otherMatrix.row1 objectAtIndex:i] intValue];
            NSInteger finalRow2 = [[matrix.row2 objectAtIndex:i] intValue] * [[otherMatrix.row2 objectAtIndex:i] intValue];
            NSInteger finalRow3 = [[matrix.row3 objectAtIndex:i] intValue] * [[otherMatrix.row3 objectAtIndex:i] intValue];
            [finalMatrix.row1 replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:finalRow1]];
            [finalMatrix.row2 replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:finalRow2]];
            [finalMatrix.row3 replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:finalRow3]];
        }
    }
    return finalMatrix;
}
/*
 - (Matrix *)determinant:(Matrix *)matrix
 {
 
 }
 
 - (Matrix *)inverse:(Matrix *)matrix
 {
 
 }
 */

@end
