//
//  Matrix.m
//  Matrices
//
//  Created by Jono Muller on 27/12/2013.
//  Copyright (c) 2013 Jono Muller. All rights reserved.
//

#import "Matrix.h"

@implementation Matrix

@synthesize row, column, elements, name, det, useAlgebra;

- (void)initialise
{
    NSMutableArray *row1 = [[NSMutableArray alloc] initWithCapacity:column];
    elements = [[NSMutableArray alloc] initWithCapacity:row];
    
    for (int i = 0; i < column; i++) {
        [row1 addObject:@""];
    }
    
    for (int i = 0; i < row; i++) {
        [elements addObject:[row1 mutableCopy]];
    }
}

- (Matrix *)copyMatrix
{
    Matrix *copy = [[Matrix alloc] init];
    copy.row = row;
    copy.column = column;
    copy.elements = elements;
    copy.name = name;
    copy.det = det;
    copy.useAlgebra = useAlgebra;
    return copy;
}

- (float)addition:(Matrix *)matrix add:(Matrix *)otherMatrix row:(NSInteger)rowPos column:(NSInteger)columnPos
{
    Matrix *finalMatrix = [[Matrix alloc] init];
    finalMatrix.row = matrix.row;
    finalMatrix.column = matrix.column;
    [finalMatrix initialise];
    float finalElement = 0;
    if ((matrix.row == otherMatrix.row) && (matrix.column == otherMatrix.column)) {
        finalElement = [[[matrix.elements objectAtIndex:rowPos] objectAtIndex:columnPos] floatValue] + [[[otherMatrix.elements objectAtIndex:rowPos] objectAtIndex:columnPos] floatValue];
        [[finalMatrix.elements objectAtIndex:rowPos] replaceObjectAtIndex:columnPos withObject:[NSNumber numberWithInt:finalElement]];
    }

    return finalElement;
}

- (float)subtraction:(Matrix *)matrix subtract:(Matrix *)otherMatrix row:(NSInteger)rowPos column:(NSInteger)columnPos
{
    Matrix *finalMatrix = [[Matrix alloc] init];
    finalMatrix.row = matrix.row;
    finalMatrix.column = matrix.column;
    [finalMatrix initialise];
    float finalElement = 0;
    if ((matrix.row == otherMatrix.row) && (matrix.column == otherMatrix.column)) {
        finalElement = [[[matrix.elements objectAtIndex:rowPos] objectAtIndex:columnPos] floatValue] - [[[otherMatrix.elements objectAtIndex:rowPos] objectAtIndex:columnPos] floatValue];
        [[finalMatrix.elements objectAtIndex:rowPos] replaceObjectAtIndex:columnPos withObject:[NSNumber numberWithInt:finalElement]];
    }

    return finalElement;
}

- (float)multiplication:(Matrix *)matrix multiply:(Matrix *)otherMatrix row1:(NSInteger)rowPos1 column1:(NSInteger)columnPos1 row2:(NSInteger)rowPos2 column2:(NSInteger)columnPos2 numberOfColumns:(NSInteger)columns
{
    Matrix *finalMatrix = [[Matrix alloc] init];
    finalMatrix.row = matrix.row;
    finalMatrix.column = otherMatrix.column;
    [finalMatrix initialise];
    float finalElement = 0;
    if (matrix.column == otherMatrix.row) {
        for (int i = 0; i < matrix.column; i++) {
            finalElement+=([[[matrix.elements objectAtIndex:rowPos1] objectAtIndex:columnPos1+i] floatValue] * [[[otherMatrix.elements objectAtIndex:rowPos2+i] objectAtIndex:columnPos2] floatValue]);
        }
        [[finalMatrix.elements objectAtIndex:rowPos1] replaceObjectAtIndex:columnPos1 withObject:[NSNumber numberWithInt:finalElement]];
    }

    return finalElement;
}

- (float)determinant:(Matrix *)matrix
{
    float determinant = 0, negativeSign = 1;
    Matrix *detMatrix = [[Matrix alloc] init];
    detMatrix.row = matrix.row - 1;
    detMatrix.column = matrix.column - 1;
    [detMatrix initialise];
    
    if (matrix.row == 1) {
        determinant = [[[matrix.elements objectAtIndex:0] objectAtIndex:0] floatValue];
    } else if (matrix.row == 2) {
        determinant = ([[[matrix.elements objectAtIndex:0] objectAtIndex:0] floatValue] * [[[matrix.elements objectAtIndex:1] objectAtIndex:1] floatValue]) - ([[[matrix.elements objectAtIndex:0] objectAtIndex:1] floatValue] * [[[matrix.elements objectAtIndex:1] objectAtIndex:0] floatValue]);
    } else {
        for (int i = 0; i < matrix.column; i++) {
            
            for (int j = 0; j < detMatrix.row; j++) {
                [detMatrix.elements replaceObjectAtIndex:j withObject:[NSMutableArray arrayWithArray:[matrix.elements objectAtIndex:j+1]]];
                [[detMatrix.elements objectAtIndex:j] removeObjectAtIndex:i];
            }
            
            determinant+=[[[matrix.elements objectAtIndex:0] objectAtIndex:i] floatValue] * [detMatrix determinant:detMatrix] * negativeSign;
            negativeSign*=-1;
        }
    }
    
    return determinant;
}

- (Matrix *)determinantMatrix:(Matrix *)matrix row:(NSInteger)currentRow column:(NSInteger)currentColumn
{
    Matrix *detMatrix = [[Matrix alloc] init];
    detMatrix.row = matrix.row - 1;
    detMatrix.column = matrix.column - 1;
    [detMatrix initialise];
    
    for (int i = 0; i < [matrix.elements count]; i++) {
        [detMatrix.elements insertObject:[NSMutableArray arrayWithArray:[matrix.elements objectAtIndex:i]] atIndex:i];
    }
    
    for (int i = 0; i < matrix.row; i++) {
        [[detMatrix.elements objectAtIndex:i] removeObjectAtIndex:currentColumn];
    }
    
    [detMatrix.elements removeObjectAtIndex:currentRow];
    
    return detMatrix;
}

- (Matrix *)inverse:(Matrix *)matrix
{
    float determinant;
    if (matrix.row > 1) {
        determinant = [matrix determinant:matrix];
    }
    NSInteger negativeSign = 1;
    Matrix *inverseMatrix = [[Matrix alloc] init];
    inverseMatrix.row = matrix.row;
    inverseMatrix.column = matrix.column;
    [inverseMatrix initialise];
    
    Matrix *tempMatrix = [[Matrix alloc] init];
    tempMatrix.row = inverseMatrix.row;
    tempMatrix.column = inverseMatrix.column;
    [tempMatrix initialise];
    
    float inverse = 0;
    
    if (matrix.row == 1) {
        inverse = 1.0 / (float)[[[matrix.elements objectAtIndex:0] objectAtIndex:0] floatValue];
        [[inverseMatrix.elements objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:inverse]];
    } else if (matrix.row == 2) {
        [[inverseMatrix.elements objectAtIndex:0] replaceObjectAtIndex:0 withObject:[[matrix.elements objectAtIndex:1] objectAtIndex:1]];
        [[inverseMatrix.elements objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:[[[matrix.elements objectAtIndex:0] objectAtIndex:1] floatValue] * -1]];
        [[inverseMatrix.elements objectAtIndex:1] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:[[[matrix.elements objectAtIndex:1] objectAtIndex:0] floatValue] * -1]];
        [[inverseMatrix.elements objectAtIndex:1] replaceObjectAtIndex:1 withObject:[[matrix.elements objectAtIndex:0] objectAtIndex:0]];
        /*
         for (int i = 0; i < [matrix.row floatValue]; i++) {
         for (int j = 0; j < [matrix.row floatValue]; j++) {
         NSInteger *element = [[[inverseMatrix.elements objectAtIndex:i] objectAtIndex:j] floatValue];
         element = element / determinant;
         }
         }*/
    } else {
        for (int i = 0; i < matrix.row; i++) {
            for (int j = 0; j < matrix.row; j++) {
                [[inverseMatrix.elements objectAtIndex:i] replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:[matrix cofactor:matrix row:i column:j]]];
                negativeSign*=-1;
            }
        }
        for (int i = 0; i < matrix.row; i++) {
            for (int j = 0; j < matrix.row; j++) {
                [[inverseMatrix.elements objectAtIndex:i] replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:[inverseMatrix divideByDeterminant:inverseMatrix row:i column:j determinant:determinant]]];
            }
        }
    }
    
    inverse = 1.0 / (float)determinant;
    
    //    NSLog(@"%f", inverse);
    //    NSLog(@"%@", inverseMatrix.elements);
    
    NSLog(@"1/%f (%@)", determinant, inverseMatrix.elements);
    
    return inverseMatrix;
}

- (float)cofactor:(Matrix *)matrix row:(NSInteger)currentRow column:(NSInteger)currentColumn
{
    Matrix *tempMatrix = [[Matrix alloc] init];
    tempMatrix.row = matrix.row - 1;
    tempMatrix.column = matrix.column - 1;
    
    float cofactor = 0;
    
    tempMatrix.elements = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [matrix.elements count]; i++) {
        [tempMatrix.elements insertObject:[NSMutableArray arrayWithArray:[matrix.elements objectAtIndex:i]] atIndex:i];
    }
    
    for (int i = 0; i < matrix.row; i++) {
        [[tempMatrix.elements objectAtIndex:i] removeObjectAtIndex:currentColumn];
    }
    
    [tempMatrix.elements removeObjectAtIndex:currentRow];
    
    cofactor = [tempMatrix determinant:tempMatrix];
    
    if ((currentRow + currentColumn) % 2 != 0) {
        cofactor*=-1;
    }
    
    return cofactor;
}

- (float)transpose:(Matrix *)matrix row:(NSInteger)currentRow column:(NSInteger)currentColumn
{
    Matrix *transposedMatrix = [[Matrix alloc] init];
    transposedMatrix.row = matrix.row;
    transposedMatrix.column = matrix.column;
    [transposedMatrix initialise];
    
    for (int i = 0; i < matrix.row; i++) {
        for (int j = 0; j < matrix.row; j++) {
            [[transposedMatrix.elements objectAtIndex:i] replaceObjectAtIndex:j withObject:[[matrix.elements objectAtIndex:j] objectAtIndex:i]];
        }
    }
    
    return [[[transposedMatrix.elements objectAtIndex:currentRow] objectAtIndex:currentColumn] floatValue];
}

- (float)divideByDeterminant:(Matrix *)matrix row:(NSInteger)currentRow column:(NSInteger)currentColumn determinant:(float)determinant
{
    float element = 0;
    
    element = [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:currentColumn] floatValue];
    element = element / determinant;
    
    return element;
}

- (float)solveLinearEquation:(Matrix *)matrix row:(NSInteger)currentRow column:(NSInteger)currentColumn
{
    float a = 0;
    
    Matrix *detMatrix;
    
    if (matrix.row == 3) {
        detMatrix = [matrix determinantMatrix:matrix row:currentRow column:currentColumn];
    }
    
    NSInteger oppositeRow, oppositeColumn, otherRow, otherColumn, otherOppositeRow, otherOppositeColumn;
    
    Matrix *detMatrix1, *detMatrix2, *detMatrix3;
    
    detMatrix1 = [matrix determinantMatrix:matrix row:currentRow column:0];

    if (matrix.row == 3) {
        detMatrix2 = [matrix determinantMatrix:matrix row:currentRow column:1];
        detMatrix3 = [matrix determinantMatrix:matrix row:currentRow column:2];
    } else if (matrix.row == 2) {
        detMatrix2 = [matrix determinantMatrix:matrix row:currentRow column:1];
    }
    
    switch (matrix.row) {
        case 1:
            a = [[[matrix.elements objectAtIndex:0] objectAtIndex:0] floatValue];
            break;
        case 2:
            
            if (currentRow == 0) {
                oppositeRow = 1;
                otherRow = 0;
            } else {
                oppositeRow = 0;
                otherRow = 1;
            }
            
            if (currentColumn == 0) {
                oppositeColumn = 1;
                otherColumn = 1;
            } else {
                oppositeColumn = 0;
                otherColumn = 0;
            }
            
            if (otherRow == 0) {
                otherOppositeRow = 1;
            } else {
                otherOppositeRow = 0;
            }
            
            if (otherColumn == 0) {
                otherOppositeColumn = 1;
            } else {
                otherOppositeColumn = 0;
            }
            
            if (((currentRow == 0) && (currentColumn == 1)) || ((currentRow == 1) && (currentColumn == 0))) {
                a = matrix.det - ([[[matrix.elements objectAtIndex:otherRow] objectAtIndex:otherColumn] floatValue] * [[[matrix.elements objectAtIndex:otherOppositeRow] objectAtIndex:otherOppositeColumn] floatValue]);
            } else {
                a = matrix.det + ([[[matrix.elements objectAtIndex:otherRow] objectAtIndex:otherColumn] floatValue] * [[[matrix.elements objectAtIndex:otherOppositeRow] objectAtIndex:otherOppositeColumn] floatValue]);
            }
            
            a = a / [[[matrix.elements objectAtIndex:oppositeRow] objectAtIndex:oppositeColumn] floatValue];
            
            if (((currentRow == 0) && (currentColumn == 1)) || ((currentRow == 1) && (currentColumn == 0))) {
                a = -a;
            }
            break;
        case 3:
            if (currentRow == 1) {
                switch (currentColumn) {
                    case 0:
                        a = [detMatrix2 determinant:detMatrix2] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:1] floatValue] - [detMatrix3 determinant:detMatrix3] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:2] floatValue] - matrix.det;
                        a = a / [detMatrix1 determinant:detMatrix1];
                        break;
                    case 1:
                        a = matrix.det + [detMatrix1 determinant:detMatrix1] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:0] floatValue] + [detMatrix3 determinant:detMatrix3] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:2] floatValue];
                        a = a / [detMatrix2 determinant:detMatrix2];
                        break;
                    case 2:
                        a = [detMatrix2 determinant:detMatrix2] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:1] floatValue] - [detMatrix1 determinant:detMatrix1] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:0] floatValue] - matrix.det;
                        a = a / [detMatrix3 determinant:detMatrix3];
                    default:
                        break;
                }
                
            } else {
                switch (currentColumn) {
                    case 0:
                        a = matrix.det + [detMatrix2 determinant:detMatrix2] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:1] floatValue] - [detMatrix3 determinant:detMatrix3] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:2] floatValue];
                        a = a / [detMatrix1 determinant:detMatrix1];
                        break;
                    case 1:
                        a = [detMatrix1 determinant:detMatrix1] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:0] floatValue] + [detMatrix3 determinant:detMatrix3] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:2] floatValue] - matrix.det;
                        a = a / [detMatrix2 determinant:detMatrix2];
                        break;
                    case 2:
                        a = matrix.det + [detMatrix2 determinant:detMatrix2] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:1] floatValue] - [detMatrix1 determinant:detMatrix1] * [[[matrix.elements objectAtIndex:currentRow] objectAtIndex:0] floatValue];
                        a = a / [detMatrix3 determinant:detMatrix3];
                    default:
                        break;
                }
            }
            break;
        default:
            break;
    }
    
    return a;
}

- (Matrix *)convertTransformationToMatrix:(NSMutableDictionary *)transformation
{
    Matrix *matrix = [[Matrix alloc] init];
    matrix.row = 2;
    matrix.column = 2;
    [matrix initialise];
    
    float detail = [[transformation objectForKey:@"detail"] floatValue];
    
    NSString *line = [transformation objectForKey:@"line"];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@" ="];
    line = [[line componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    
    switch ([[transformation objectForKey:@"type"] integerValue]) {
        case 0:
            detail = detail * M_PI / 180;
            [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:cosf(detail)]];
            [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:sinf(detail)]];
            [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:-sinf(detail)]];
            [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:cosf(detail)]];
            break;
        case 1:
            if ([[line substringToIndex:1] isEqualToString:@"y"]) {
                if ([[line substringFromIndex:([line length] - 1)] isEqualToString:@"x"]) {
                    detail = atanf([[line substringWithRange:NSMakeRange(1, [line length] - 2)] floatValue]);
                } else {
                    detail = 0;
                }
                [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:cosf(detail*2)]];
                [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:sinf(detail*2)]];
                [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:sinf(detail*2)]];
                [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:-cosf(detail*2)]];
            } else {
                [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:-1]];
                [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:0]];
                [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:0]];
                [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:1]];
            }
            break;
        case 2:
            [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:detail]];
            [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:0]];
            [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:0]];
            [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:detail]];
            break;
        case 3:
            [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:0]];
            [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:0]];
            if ([transformation objectForKey:@"axis"] == 0) {
                [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:detail]];
                [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:1]];
            } else {
                [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:1]];
                [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:detail]];
            }
            break;
        case 4:
            [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:1]];
            [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:1]];
            if ([transformation objectForKey:@"axis"] == 0) {
                [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:detail]];
                [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:0]];
            } else {
                [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:0]];
                [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:detail]];
            }
            break;
        default:
            break;
    }
    
    return matrix;
}

- (NSMutableDictionary *)convertMatrixToTransformation:(Matrix *)matrix
{
    NSMutableDictionary *transformation = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *transformationTypes = [[NSMutableArray alloc] initWithObjects:@"Rotation", @"Reflection", @"Enlargement", @"Stretch", @"Shear", nil];
    
    float cosI, sinI, cos2I, sin2I;
    
    NSString *element1 = [NSString stringWithFormat:@"%@", [[matrix.elements objectAtIndex:0] objectAtIndex:0]];
    
    if ([[[matrix.elements objectAtIndex:0] objectAtIndex:0] floatValue] != floorf([[[matrix.elements objectAtIndex:0] objectAtIndex:0] floatValue])) {
        NSRange range = [element1 rangeOfString:@"."];
        element1 = [element1 substringFromIndex:range.location + 1];
    }
    
    NSLog(@"%d", [element1 length]);
    
    NSString *line;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumSignificantDigits = 3;
    formatter.usesSignificantDigits = YES;
    
    for (float i = 0; i <= M_PI * 2; i+=0.01) {
        cosI = [[NSString stringWithFormat:@"%.3f", cosf(i)] floatValue];
        sinI = [[NSString stringWithFormat:@"%.3f", sinf(i)] floatValue];
        cos2I = [[NSString stringWithFormat:@"%.2f", cosf(2*i)] floatValue];
        sin2I = [[NSString stringWithFormat:@"%.2f", sinf(2*i)] floatValue];
        
        switch ([element1 length]) {
            case 1:
                cosI = [[NSString stringWithFormat:@"%.1f", cosf(i)] floatValue];
                sinI = [[NSString stringWithFormat:@"%.1f", sinf(i)] floatValue];
                cos2I = [[NSString stringWithFormat:@"%.1f", cosf(2*i)] floatValue];
                sin2I = [[NSString stringWithFormat:@"%.1f", sinf(2*i)] floatValue];
                break;
            case 2:
                cosI = [[NSString stringWithFormat:@"%.2f", cosf(i)] floatValue];
                sinI = [[NSString stringWithFormat:@"%.2f", sinf(i)] floatValue];
                cos2I = [[NSString stringWithFormat:@"%.2f", cosf(2*i)] floatValue];
                sin2I = [[NSString stringWithFormat:@"%.2f", sinf(2*i)] floatValue];
                break;
            default:
                break;
        }
        
        float angle = roundf(i*180/M_PI);
        
        // Rotation check
        if (([[[matrix.elements objectAtIndex:0] objectAtIndex:0] floatValue] == cosI) && ([[[matrix.elements objectAtIndex:0] objectAtIndex:1] floatValue] == sinI) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:0] floatValue] == -sinI) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:1] floatValue] == cosI)) {
            [transformation setObject:[NSNumber numberWithInteger:0] forKey:@"type"];
            [transformation setObject:[transformationTypes objectAtIndex:0] forKey:@"typeString"];
            [transformation setObject:[NSNumber numberWithFloat:angle] forKey:@"detail"];
            return transformation;
        }
        
        // Reflection check
        if (([[[matrix.elements objectAtIndex:0] objectAtIndex:0] floatValue] == cos2I) && ([[[matrix.elements objectAtIndex:0] objectAtIndex:1] floatValue] == sin2I) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:0] floatValue] == sin2I) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:1] floatValue] == -cos2I)) {
            
            if (([[[matrix.elements objectAtIndex:0] objectAtIndex:0] floatValue] == -1) && ([[[matrix.elements objectAtIndex:0] objectAtIndex:1] floatValue] == 0) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:0] floatValue] == 0) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:1] floatValue] == 1)) {
                line = @"x = 0";
            } else if (tanf(i) == 0) {
                line = @"y = 0";
            } else {
                line = [NSString stringWithFormat:@"y = %@x", [formatter stringFromNumber:[NSNumber numberWithFloat:tanf(i)]]];
            }
            
            [transformation setObject:[NSNumber numberWithInteger:1] forKey:@"type"];
            [transformation setObject:[transformationTypes objectAtIndex:1] forKey:@"typeString"];
            [transformation setObject:line forKey:@"line"];
            return transformation;
        }
    }
    
    for (float i = -100; i < 100; i++) {
        
        // Enlargement check
        if (([[[matrix.elements objectAtIndex:0] objectAtIndex:0] intValue] == i) && ([[[matrix.elements objectAtIndex:0] objectAtIndex:1] intValue] == 0) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:0] intValue] == 0) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:1] intValue] == i)) {
            [transformation setObject:[NSNumber numberWithInteger:2] forKey:@"type"];
            [transformation setObject:[transformationTypes objectAtIndex:2] forKey:@"typeString"];
            [transformation setObject:[NSNumber numberWithFloat:i] forKey:@"detail"];
            return transformation;
        }
        
        // Strech check
        if (([[[matrix.elements objectAtIndex:0] objectAtIndex:1] intValue] == 0) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:0] intValue] == 0) && ([[[matrix.elements objectAtIndex:0] objectAtIndex:0] intValue] == i) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:1] intValue] == 1)) {
            [transformation setObject:[NSNumber numberWithInteger:3] forKey:@"type"];
            [transformation setObject:[transformationTypes objectAtIndex:3] forKey:@"typeString"];
            [transformation setObject:[NSNumber numberWithFloat:i] forKey:@"detail"];
            [transformation setObject:[NSNumber numberWithInt:0] forKey:@"axis"];
            return transformation;
        } else if (([[[matrix.elements objectAtIndex:0] objectAtIndex:1] intValue] == 0) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:0] intValue] == 0) && ([[[matrix.elements objectAtIndex:0] objectAtIndex:0] intValue] == 1) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:1] intValue] == i)) {
            [transformation setObject:[NSNumber numberWithInteger:3] forKey:@"type"];
            [transformation setObject:[transformationTypes objectAtIndex:3] forKey:@"typeString"];
            [transformation setObject:[NSNumber numberWithFloat:i] forKey:@"detail"];
            [transformation setObject:[NSNumber numberWithInt:1] forKey:@"axis"];
            return transformation;
        }
        
        // Shear check
        if (([[[matrix.elements objectAtIndex:0] objectAtIndex:0] intValue] == 1) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:1] intValue] == 1)) {
            [transformation setObject:[NSNumber numberWithInteger:4] forKey:@"type"];
            [transformation setObject:[transformationTypes objectAtIndex:4] forKey:@"typeString"];
            if (([[[matrix.elements objectAtIndex:0] objectAtIndex:1] intValue] == i) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:0] intValue] == 0)) {
                [transformation setObject:[NSNumber numberWithFloat:i] forKey:@"detail"];
                [transformation setObject:[NSNumber numberWithInt:0] forKey:@"axis"];
            } else if (([[[matrix.elements objectAtIndex:0] objectAtIndex:1] intValue] == 0) && ([[[matrix.elements objectAtIndex:1] objectAtIndex:0] intValue] == i)) {
                [transformation setObject:[NSNumber numberWithFloat:i] forKey:@"detail"];
                [transformation setObject:[NSNumber numberWithInt:1] forKey:@"axis"];
            }
        }
    }
    
    return transformation;
}

@end
