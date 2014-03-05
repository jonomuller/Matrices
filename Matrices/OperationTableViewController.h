//
//  OperationTableViewController.h
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Matrix.h"

@protocol OperationViewDelegate <NSObject>

- (void)passBackOperation:(NSString *)operation;
- (void)passBackOperationIndex:(NSInteger)index;
- (void)passBackFirstIndex:(NSInteger)row;
- (void)passBackSecondIndex:(NSInteger)row;

@end

@interface OperationTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) id <OperationViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIPickerView *listOfOperations, *listOfMatrices;

@property (strong, nonatomic) NSMutableArray *operations, *matrices, *names;;
@property (strong, nonatomic) NSString *selectedOperation, *operationTitle;

@property (strong, nonatomic) NSMutableArray *headers;

@property (nonatomic) NSInteger operationIndex, firstMatrixIndex, secondMatrixIndex;

@end
