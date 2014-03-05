//
//  MatrixTableViewController.m
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import "MatrixTableViewController.h"

@interface MatrixTableViewController ()
{
    Matrix *matrix;
    NSArray *textFields, *firstRow, *secondRow, *thirdRow;
    NSMutableArray *returnFields;
    NSInteger initial;
}

@end

@implementation MatrixTableViewController

@synthesize rowsInSection, headers, textField1, textField2, textField3, textField4, textField5, textField6, textField7, textField8, textField9, textField10, textField11, nameTextField, leftBracket, rightBracket, alert, matrices, delegate, indexPathRow, fromButton, valid;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (matrices) {
        if (fromButton) {
            matrix = [[Matrix alloc] init];
        } else {
            matrix = [matrices objectAtIndex:indexPathRow];
        }
    } else {
        matrices = [[NSMutableArray alloc] init];
        matrix = [[Matrix alloc] init];
    }
    
    rowsInSection = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], nil];
    headers = [[NSMutableArray alloc] initWithObjects:@"Name", @"Matrix size", @"Matrix elements", nil];
    
    textField1 = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, 290, 34)];
    textField2 = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, 290, 34)];
    
    textField3 = [[UITextField alloc] initWithFrame:CGRectMake(35, 5, 50, 34)];
    textField4 = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, 50, 34)];
    textField5 = [[UITextField alloc] initWithFrame:CGRectMake(145, 5, 50, 34)];
    textField6 = [[UITextField alloc] initWithFrame:CGRectMake(35, 49, 50, 34)];
    textField7 = [[UITextField alloc] initWithFrame:CGRectMake(90, 49, 50, 34)];
    textField8 = [[UITextField alloc] initWithFrame:CGRectMake(145, 49, 50, 34)];
    textField9 = [[UITextField alloc] initWithFrame:CGRectMake(35, 93, 50, 34)];
    textField10 = [[UITextField alloc] initWithFrame:CGRectMake(90, 93, 50, 34)];
    textField11 = [[UITextField alloc] initWithFrame:CGRectMake(145, 93, 50, 34)];
    
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, 290, 34)];
    
    returnFields = [[NSMutableArray alloc] initWithObjects:nameTextField, textField1, textField2, nil];
    
    NSArray *firstFields = @[textField1, textField2];
    
    for (UITextField *field in firstFields) {
        field.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        field.delegate = self;
        field.placeholder = @"tap to enter value";
    }
    
    textField2.returnKeyType = UIReturnKeyDone;
    
    textFields = @[textField3, textField4, textField5, textField6, textField7, textField8, textField9, textField10, textField11];
    
    for (UITextField *field in textFields) {
        field.placeholder = @"-";
        field.textAlignment = NSTextAlignmentCenter;
        field.delegate = self;
        field.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        field.hidden = YES;
        field.adjustsFontSizeToFitWidth = YES;
    }
    
    nameTextField.placeholder = @"tap to enter name";
    nameTextField.delegate = self;
    
    [textField1 addTarget:self action:@selector(textField1Changed:) forControlEvents:UIControlEventEditingChanged];
    [textField2 addTarget:self action:@selector(textField2Changed:) forControlEvents:UIControlEventEditingChanged];
    
    [textField3 addTarget:self action:@selector(textField3Changed:) forControlEvents:UIControlEventEditingChanged];
    [textField4 addTarget:self action:@selector(textField4Changed:) forControlEvents:UIControlEventEditingChanged];
    [textField5 addTarget:self action:@selector(textField5Changed:) forControlEvents:UIControlEventEditingChanged];
    [textField6 addTarget:self action:@selector(textField6Changed:) forControlEvents:UIControlEventEditingChanged];
    [textField7 addTarget:self action:@selector(textField7Changed:) forControlEvents:UIControlEventEditingChanged];
    [textField8 addTarget:self action:@selector(textField8Changed:) forControlEvents:UIControlEventEditingChanged];
    [textField9 addTarget:self action:@selector(textField9Changed:) forControlEvents:UIControlEventEditingChanged];
    [textField10 addTarget:self action:@selector(textField10Changed:) forControlEvents:UIControlEventEditingChanged];
    [textField11 addTarget:self action:@selector(textField11Changed:) forControlEvents:UIControlEventEditingChanged];
    
    [nameTextField addTarget:self action:@selector(nameTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    firstRow = @[textField3, textField4, textField5];
    secondRow = @[textField6, textField7, textField8];
    thirdRow = @[textField9, textField10, textField11];
    
    if ((!fromButton) && ([matrices count] > 0)) {
        textField1.text = [NSString stringWithFormat:@"%d", matrix.row];
        textField2.text = [NSString stringWithFormat:@"%d", matrix.column];
        nameTextField.text = matrix.name;
        for (int i = 0; i < matrix.column; i++) {
            UITextField *field1 = [firstRow objectAtIndex:i];
            UITextField *field2 = [secondRow objectAtIndex:i];
            UITextField *field3 = [thirdRow objectAtIndex:i];
            switch (matrix.row) {
                case 1:
                    field1.text = [NSString stringWithFormat:@"%@", [[matrix.elements objectAtIndex:0] objectAtIndex:i]];
                    break;
                case 2:
                    field1.text = [NSString stringWithFormat:@"%@", [[matrix.elements objectAtIndex:0] objectAtIndex:i]];
                    field2.text = [NSString stringWithFormat:@"%@", [[matrix.elements objectAtIndex:1] objectAtIndex:i]];
                    break;
                case 3:
                    field1.text = [NSString stringWithFormat:@"%@", [[matrix.elements objectAtIndex:0] objectAtIndex:i]];
                    field2.text = [NSString stringWithFormat:@"%@", [[matrix.elements objectAtIndex:1] objectAtIndex:i]];
                    field3.text = [NSString stringWithFormat:@"%@", [[matrix.elements objectAtIndex:2] objectAtIndex:i]];
                    break;
                default:
                    break;
            }
        }
        
        [self generateMatrixFields:matrix.row numberOfColumns:matrix.column];
    }
    
    initial = 0;
    
    alert = [[UIAlertView alloc] initWithTitle:@"Validation error"
                                       message:@"Please enter an integer between 1 and 3 inclusive"
                                      delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:NULL, nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButton:)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [headers count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[rowsInSection objectAtIndex:section] intValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 2) && (matrix.row != 0)) {
        return matrix.row * 44;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    
    // Configure the cell...
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 2) {
        for (UITextField *field in textFields) {
            [cell addSubview:field];
        }
        [cell addSubview:leftBracket];
        [cell addSubview:rightBracket];
    } else if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell addSubview:nameTextField];
        } else {
            cell.contentView.backgroundColor = self.tableView.backgroundColor;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"no. of rows";
            [cell.contentView addSubview:textField1];
        } else if (indexPath.row == 1) {
            cell.detailTextLabel.text = @"no. of columns";
            [cell.contentView addSubview:textField2];
        }
    }
    
    cell.textLabel.text = @"";
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [headers objectAtIndex:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *footer;
    if ((section == 1) && ([textField1.text intValue] > 0) && ([textField2.text intValue] > 0) && ([textField1.text intValue] < 4) && ([textField2.text intValue] < 4)) {
        footer = [NSString stringWithFormat:@"Matrix with size %d x %d", matrix.row, matrix.column];
    }
    return footer;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UITextField *otherTextField;
    
    if (textField == textField1) {
        otherTextField = textField2;
    } else if (textField == textField2) {
        otherTextField = textField1;
    }
    
    if ((![[NSScanner scannerWithString:otherTextField.text] scanInt:nil]) && ([otherTextField.text length])) {
        [alert show];
        otherTextField.text = @"";
    }
    
    if ([otherTextField.text intValue] != 0) {
        if (([otherTextField.text intValue] > 3) || ([otherTextField.text intValue] < 1)) {
            [alert show];
            otherTextField.text = @"";
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self dismissKeyboard];
    
    if (textField == [returnFields lastObject]) {
        [textField resignFirstResponder];
    } else {
        NSInteger test = [returnFields indexOfObject:textField];
        [[returnFields objectAtIndex:test+1] becomeFirstResponder];
    }
    
    return NO;
}

- (IBAction)textField1Changed:(id)sender
{
    [self enableSaveButton];
    matrix.row = [textField1.text intValue];
}

- (IBAction)textField2Changed:(id)sender
{
    [self enableSaveButton];
    matrix.column = [textField2.text intValue];
}

- (IBAction)textField3Changed:(id)sender
{
    [self enableSaveButton];
    [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:[textField3.text floatValue]]];
}

- (IBAction)textField4Changed:(id)sender
{
    [self enableSaveButton];
    [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:[textField4.text floatValue]]];
}

- (IBAction)textField5Changed:(id)sender
{
    [self enableSaveButton];
    [[matrix.elements objectAtIndex:0] replaceObjectAtIndex:2 withObject:[NSNumber numberWithFloat:[textField5.text floatValue]]];
}

- (IBAction)textField6Changed:(id)sender
{
    [self enableSaveButton];
    [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:[textField6.text floatValue]]];
}

- (IBAction)textField7Changed:(id)sender
{
    [self enableSaveButton];
    [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:[textField7.text floatValue]]];
}

- (IBAction)textField8Changed:(id)sender
{
    [self enableSaveButton];
    [[matrix.elements objectAtIndex:1] replaceObjectAtIndex:2 withObject:[NSNumber numberWithFloat:[textField8.text floatValue]]];
}

- (IBAction)textField9Changed:(id)sender
{
    [self enableSaveButton];
    [[matrix.elements objectAtIndex:2] replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:[textField9.text floatValue]]];
}

- (IBAction)textField10Changed:(id)sender
{
    [self enableSaveButton];
    [[matrix.elements objectAtIndex:2] replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:[textField10.text floatValue]]];
}

- (IBAction)textField11Changed:(id)sender
{
    [self enableSaveButton];
    [[matrix.elements objectAtIndex:2] replaceObjectAtIndex:2 withObject:[NSNumber numberWithFloat:[textField11.text floatValue]]];
}

- (IBAction)nameTextFieldChanged:(id)sender
{
    [self enableSaveButton];
    matrix.name = nameTextField.text;
}

#pragma mark - Save button

- (IBAction)saveButton:(id)sender
{
    textField1.text = @"";
    textField2.text = @"";
    for (UITextField *field in textFields) {
        field.text = @"";
        field.hidden = YES;
    }
    leftBracket.hidden = YES;
    rightBracket.hidden = YES;
    nameTextField.text = @"";
    [self.tableView reloadData];
    
    if ((!fromButton) && ([matrices count] > 0)) {
        [matrices replaceObjectAtIndex:indexPathRow withObject:[matrix copyMatrix]];
    } else {
        [matrices addObject:[matrix copyMatrix]];
    }
    
    [self.delegate passBackMatricesArray:matrices];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)enableSaveButton
{
    BOOL complete = TRUE;
    
    if (textField3.hidden) {
        complete = FALSE;
    }
    
    for (UITextField *field in textFields) {
        if (([field.text isEqualToString:@""]) && (!field.hidden)) {
            complete = FALSE;
        }
    }
    
    if ([textField1.text isEqualToString:@""] || [textField2.text isEqualToString:@""] || [nameTextField.text isEqualToString:@""]) {
        complete = FALSE;
    }
    
    if (complete) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

#pragma mark - Generate matrix fields

- (void)generateMatrixFields:(int)row numberOfColumns:(int)column
{
    BOOL allEmpty = TRUE;
    
    for (UITextField *field in textFields) {
        if (![field.text isEqualToString:@""]) {
            allEmpty = FALSE;
        }
    }
    
    if ((allEmpty) && (fromButton)) {
        [matrix initialise];
    }
    
    initial++;
    
    if ((matrix.row != 0) && (matrix.column != 0)) {
        leftBracket = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 20, (matrix.row * 44) - 10)];
        leftBracket.image = [UIImage imageNamed:@"leftBracket.png"];
        
        rightBracket = [[UIImageView alloc] initWithFrame:CGRectMake((matrix.column * 50) + 35 + ((matrix.column - 1) * 5), 5, 20, (matrix.row * 44) - 10)];
        rightBracket.image = [UIImage imageNamed:@"rightBracket.png"];
    }
    
    for (int i = 0; i < column; i++) {
        switch (row) {
            case 1:
                [[firstRow objectAtIndex:i] setHidden:NO];
                for (int j = column; j < 3; j++) {
                    [[firstRow objectAtIndex:j] setHidden:YES];
                }
                for (int j = 0; j < 3; j++) {
                    [[secondRow objectAtIndex:j] setHidden:YES];
                    [[thirdRow objectAtIndex:j] setHidden:YES];
                }
                break;
            case 2:
                [[firstRow objectAtIndex:i] setHidden:NO];
                [[secondRow objectAtIndex:i] setHidden:NO];
                for (int j = column; j < 3; j++) {
                    [[firstRow objectAtIndex:j] setHidden:YES];
                    [[secondRow objectAtIndex:j] setHidden:YES];
                }
                for (int j = 0; j < 3; j++) {
                    [[thirdRow objectAtIndex:j] setHidden:YES];
                }
                break;
            case 3:
                [[firstRow objectAtIndex:i] setHidden:NO];
                [[secondRow objectAtIndex:i] setHidden:NO];
                [[thirdRow objectAtIndex:i] setHidden:NO];
                for (int j = column; j < 3; j++) {
                    [[firstRow objectAtIndex:j] setHidden:YES];
                    [[secondRow objectAtIndex:j] setHidden:YES];
                    [[thirdRow objectAtIndex:j] setHidden:YES];
                }
                break;
            default:
                break;
        }
    }
    
    NSArray *firstColumn = @[textField3, textField6, textField9];
    NSArray *secondColumn = @[textField4, textField7, textField10];
    NSArray *thirdColumn = @[textField5, textField8, textField11];
    
    if ([returnFields count] == 3) {
        for (int i = 0; i < matrix.row; i++) {
            switch (matrix.column) {
                case 1:
                    [returnFields addObject:[firstColumn objectAtIndex:i]];
                    break;
                case 2:
                    [returnFields addObject:[firstColumn objectAtIndex:i]];
                    [returnFields addObject:[secondColumn objectAtIndex:i]];
                    break;
                case 3:
                    [returnFields addObject:[firstColumn objectAtIndex:i]];
                    [returnFields addObject:[secondColumn objectAtIndex:i]];
                    [returnFields addObject:[thirdColumn objectAtIndex:i]];
                    break;
                default:
                    break;
            }
        }
    }
}

#pragma mark - Dismiss keyboard

- (void)dismissKeyboard {
    [self enableSaveButton];
    [self checkIfNameIsValid];
    [self checkIfSizeIsValid];
    [self checkIfMatrixIsValid];
    
    [self.tableView reloadData];
    
    
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"limeify://"];
    
    if (([matrix.name isEqualToString:@"limeify"]) || ([matrix.name isEqualToString:@"Limeify"])) {
        [application openURL:url];
    }
}

#pragma mark - Validation checks

- (void)checkIfNameIsValid
{
    UIAlertView *nameInvalid = [[UIAlertView alloc] initWithTitle:@"Invalid name"
                                                          message:@"Please enter a name that is not the same as another matrix"
                                                         delegate:self
                                                cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];
    
    //    NSLog(@"%@", matrices);
    if ([matrices count] > 0) {
        for (int i = 0; i < [matrices count]; i++) {
            Matrix *otherMatrix = [matrices objectAtIndex:i];
            if (([matrix.name isEqualToString:otherMatrix.name]) & (i != indexPathRow)) {
                [nameInvalid show];
                nameTextField.text = NULL;
            }
        }
    }
}

- (void)checkIfSizeIsValid
{
    if ([textField1 isFirstResponder]) {
        if (([textField1.text intValue] > 3) || ([textField1.text intValue] < 1)) {
            [alert show];
            textField1.text = @"";
        }
    } else if ([textField2 isFirstResponder]) {
        if (([textField2.text intValue] > 3) || ([textField2.text intValue] < 1)) {
            [alert show];
            textField2.text = @"";
        }
    }
    if (!(([textField1.text intValue] > 3) || ([textField1.text intValue] < 1) || ([textField2.text intValue] > 3) || ([textField2.text intValue] < 1))) {
        [self generateMatrixFields:matrix.row numberOfColumns:matrix.column];
    }
}

- (void)checkIfMatrixIsValid
{
    UIAlertView *matrixError = [[UIAlertView alloc] initWithTitle:@"Validation error"
                                                          message:@"Please enter an integer"
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:NULL, nil];
    
    for (UITextField *field in textFields) {
        if ([field isFirstResponder]) {
            NSScanner *scan = [NSScanner scannerWithString:field.text];
            if (![scan scanInt:NULL]) {
                [matrixError show];
                field.text = @"";
            }
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
