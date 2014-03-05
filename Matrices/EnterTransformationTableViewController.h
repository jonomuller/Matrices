//
//  EnterTransformationTableViewController.h
//  Test
//
//  Created by Jono Muller on 05/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EnterTransformationTableViewDelegate <NSObject>

- (void)passBackTransformationsArray:(NSMutableArray *)array;

@end

@interface EnterTransformationTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id <EnterTransformationTableViewDelegate> delegate;

@property (nonatomic) BOOL fromButton;

@property (strong, nonatomic) NSMutableArray *headers, *transformationTypes, *axisTypes, *details, *transformations;

@property (strong, nonatomic) NSMutableDictionary *transformation;

@property (nonatomic) NSInteger transformationIndex, axisIndex, indexPathRow;

@property (nonatomic) float detail;

@property (strong, nonatomic) NSString *lineString;

@property (strong, nonatomic) UIPickerView *transformationTypePicker, *axisPicker;

@property (strong, nonatomic) UITextField *textField;

- (void)dismissKeyboard;
- (IBAction)textFieldEdited:(id)sender;
- (IBAction)saveButton:(id)sender;
- (void)enableSaveButton;
- (BOOL)checkIfLineIsValid;
- (BOOL)checkIfIntegerIsValid;

@end
