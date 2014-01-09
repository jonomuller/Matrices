//
//  MatrixTableViewController.h
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Matrix.h"

@protocol MatrixTableViewDelegate <NSObject>

- (void)passBackMatricesArray:(NSMutableArray *)array;

@end

@interface MatrixTableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) id <MatrixTableViewDelegate> delegate;
@property (nonatomic) BOOL fromButton;

@property (strong, nonatomic) NSMutableArray *rowsInSection;
@property (strong, nonatomic) NSMutableArray *headers;
@property (strong, nonatomic) UIAlertView *alert;
@property (strong, nonatomic) NSMutableArray *matrices;
@property (nonatomic) NSInteger indexPathRow;

@property (strong, nonatomic) IBOutlet UITextField *textField1, *textField2;

@property (strong, nonatomic) IBOutlet UITextField *textField3, *textField4, *textField5, *textField6, *textField7, *textField8, *textField9, *textField10, *textField11;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@property (strong, nonatomic) IBOutlet UIImageView *leftBracket, *rightBracket;

- (IBAction)textField1Changed:(id)sender;
- (IBAction)textField2Changed:(id)sender;
- (IBAction)textField3Changed:(id)sender;
- (IBAction)textField4Changed:(id)sender;
- (IBAction)textField5Changed:(id)sender;
- (IBAction)textField6Changed:(id)sender;
- (IBAction)textField7Changed:(id)sender;
- (IBAction)textField8Changed:(id)sender;
- (IBAction)textField9Changed:(id)sender;
- (IBAction)textField10Changed:(id)sender;
- (IBAction)textField11Changed:(id)sender;

- (IBAction)nameTextFieldChanged:(id)sender;

- (IBAction)saveButton:(id)sender;

- (void)dismissKeyboard;
- (void)generateMatrixFields:(int)row numberOfColumns:(int)column;

- (void)enableSaveButton;

- (void)checkIfNameIsValid;
- (void)checkIfSizeIsValid;
- (void)checkIfMatrixIsValid;

@end
