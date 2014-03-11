//
//  Matrix.h
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>

@interface Matrix : NSObject

@property (nonatomic) NSInteger row, column;

@property (strong, nonatomic) NSMutableArray *elements;

@property (strong, nonatomic) NSString *name;

@property (nonatomic) float det;

@property (nonatomic) BOOL useAlgebra;

- (void)initialise;
- (Matrix *)copyMatrix;

- (float)determinant:(Matrix *)matrix;

- (Matrix *)inverse:(Matrix *)matrix;
- (float)cofactor:(Matrix *)matrix row:(NSInteger)currentRow column:(NSInteger)currentColumn;
- (float)transpose:(Matrix *)matrix row:(NSInteger)currentRow column:(NSInteger)currentColumn;;
- (float)divideByDeterminant:(Matrix *)matrix row:(NSInteger)currentRow column:(NSInteger)currentColumn determinant:(float)determinant;

- (Matrix *)determinantMatrix:(Matrix *)matrix row:(NSInteger)currentRow column:(NSInteger)currentColumn;

- (float)addition:(Matrix *)matrix add:(Matrix *)otherMatrix row:(NSInteger)rowPos column:(NSInteger)columnPos;
- (float)subtraction:(Matrix *)matrix subtract:(Matrix *)otherMatrix row:(NSInteger)rowPos column:(NSInteger)columnPos;
- (float)multiplication:(Matrix *)matrix multiply:(Matrix *)otherMatrix row1:(NSInteger)rowPos1 column1:(NSInteger)columnPos1 row2:(NSInteger)rowPos2 column2:(NSInteger)columnPos2 numberOfColumns:(NSInteger)columns;

- (float)solveLinearEquation:(Matrix *)matrix row:(NSInteger)currentRow column:(NSInteger)currentColumn;

- (Matrix *)convertTransformationToMatrix:(NSMutableDictionary *)transformation;
- (NSMutableDictionary *)convertMatrixToTransformation:(Matrix *)matrix;

@end
