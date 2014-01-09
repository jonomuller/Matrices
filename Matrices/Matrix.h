//
//  Matrix.h
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Matrix : NSObject

@property (strong, nonatomic) NSNumber *row;
@property (strong, nonatomic) NSNumber *column;

@property (strong, nonatomic) NSMutableArray *row1;
@property (strong, nonatomic) NSMutableArray *row2;
@property (strong, nonatomic) NSMutableArray *row3;
@property (strong, nonatomic) NSMutableArray *elements;

@property (strong, nonatomic) NSString *name;

- (void)initialise;
- (Matrix *)copyMatrix;
- (Matrix *)addition:(Matrix *)matrix add:(Matrix *)otherMatrix;
- (Matrix *)subtraction:(Matrix *)matrix subtract:(Matrix *)otherMatrix;
- (Matrix *)multiplication:(Matrix *)matrix multiply:(Matrix *)otherMatrix;
- (Matrix *)determinant:(Matrix *)matrix;
- (Matrix *)inverse:(Matrix *)matrix;

@end
