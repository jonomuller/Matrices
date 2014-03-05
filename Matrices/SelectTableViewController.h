//
//  SelectTableViewController.h
//  Test
//
//  Created by Jono Muller on 03/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Matrix.h"

@protocol SelectTableViewDelegate <NSObject>

- (void)passBackSelectedType:(NSInteger)num;
- (void)passBackSelectedInput:(NSInteger)num;

@end

@interface SelectTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) NSInteger selectedType, selectedInput;

@property (weak, nonatomic) id <SelectTableViewDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *headers, *types, *transformations, *matrices, *matrixNames, *transformationNames, *transformationTypes;

@property (strong, nonatomic) NSMutableDictionary *transformation;

@property (strong, nonatomic) Matrix *matrix;

@property (strong, nonatomic) UIPickerView *typePicker, *inputPicker;

@end
