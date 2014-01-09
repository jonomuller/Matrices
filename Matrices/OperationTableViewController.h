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

@end

@interface OperationTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) id <OperationViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIPickerView *listOfOperations;
@property (strong, nonatomic) IBOutlet UIPickerView *listOfMatrices;

@property (strong, nonatomic) NSMutableArray *operations;
@property (strong, nonatomic) NSString *selectedOperation;
@property (strong, nonatomic) NSString *operationTitle;
@property (strong, nonatomic) NSString *matricesTitle;

@property (strong, nonatomic) NSMutableArray *matrices;
@property (strong, nonatomic) NSMutableArray *names;

@property (strong, nonatomic) NSMutableArray *headers;

@end
