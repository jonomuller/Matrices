//
//  EnterTransformationTableViewController.m
//  Test
//
//  Created by Jono Muller on 05/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import "EnterTransformationTableViewController.h"

@interface EnterTransformationTableViewController ()

@end

@implementation EnterTransformationTableViewController

@synthesize headers, transformationTypePicker, transformationTypes, transformations, transformation, transformationIndex, axisIndex, axisPicker, axisTypes, textField, details, lineString, detail, fromButton, indexPathRow;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (transformations) {
        if (fromButton) {
            transformation = [[NSMutableDictionary alloc] init];
        } else {
            transformation = [transformations objectAtIndex:indexPathRow];
        }
    } else {
        transformations = [[NSMutableArray alloc] init];
        transformation = [[NSMutableDictionary alloc] init];
    }
    
    headers = [[NSMutableArray alloc] initWithObjects:@"Transformation type", @"Details", nil];
    
    transformationTypes = [[NSMutableArray alloc] initWithObjects:@"Rotation", @"Reflection", @"Enlargement", @"Stretch", @"Shear", nil];
    
    axisTypes = [[NSMutableArray alloc] initWithObjects:@"x axis", @"y axis", nil];
    
    details = [[NSMutableArray alloc] initWithObjects:@"enter angle", @"enter reflection line", @"enter scale factor", @"enter scale factor", @"enter scale factor", nil];
    
    transformationTypePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    transformationTypePicker.delegate = self;
    
    [transformationTypePicker selectRow:[[transformation objectForKey:@"type"] integerValue] inComponent:0 animated:YES];
    
    axisPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    axisPicker.delegate = self;
    
    [axisPicker selectRow:[[transformation objectForKey:@"axis"] integerValue] inComponent:0 animated:YES];
    
    /*if (UIInterfaceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
        typeOfTransformation = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    } else {
        typeOfTransformation = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 568, 162)];
    }*/
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, 290, 34)];
    textField.delegate = self;
    
    if (!fromButton) {
        textField.text = [NSString stringWithFormat:@"%@", [transformation objectForKey:@"detail"]];
    }
    
    [textField addTarget:self action:@selector(textFieldEdited:) forControlEvents:UIControlEventEditingChanged];
    
    if (fromButton) {
        [transformation setObject:[NSNumber numberWithInteger:transformationIndex] forKey:@"type"];
        [transformation setObject:[NSString stringWithFormat:@"%@", [transformationTypes objectAtIndex:transformationIndex]] forKey:@"typeString"];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButton:)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissKeyboard
{
    
}

- (IBAction)saveButton:(id)sender
{
    if (transformationIndex == 1) {
        if ([self checkIfLineIsValid]) {
            if ((!fromButton) && ([transformations count] > 0)) {
                [transformations replaceObjectAtIndex:indexPathRow withObject:[transformation mutableCopy]];
            } else {
                [transformations addObject:[transformation mutableCopy]];
            }
            [self.delegate passBackTransformationsArray:transformations];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        if ([self checkIfIntegerIsValid]) {
            if ((!fromButton) && ([transformations count] > 0)) {
                [transformations replaceObjectAtIndex:indexPathRow withObject:[transformation mutableCopy]];
            } else {
                [transformations addObject:[transformation mutableCopy]];
            }
            [self.delegate passBackTransformationsArray:transformations];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)enableSaveButton
{
    if (![textField.text isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
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
    NSInteger rows;
    
    if ((transformationIndex > 2) && (section == 1)) {
        rows = 2;
    } else {
        rows = 1;
    }
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    
    // Configure the cell...
    
    if (indexPath.section == 0) {
        [cell addSubview:transformationTypePicker];
        [axisPicker removeFromSuperview];
    } else {
        if (transformationIndex > 2) {
            if (indexPath.row == 0) {
                [cell addSubview:axisPicker];
                cell.textLabel.text = @"Parallel to: ";
            } else {
                [cell addSubview:textField];
            }
        } else if (transformationIndex == 0) {
            [cell addSubview:textField];
            cell.textLabel.text = @"";
            cell.detailTextLabel.text = @"degrees";
        } else {
            [cell addSubview:textField];
            cell.textLabel.text = @"";
        }
    }
    
    textField.placeholder = [details objectAtIndex:transformationIndex];
    
    if (transformationIndex == 1) {
        [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    if (indexPath.section == 0) {
        height = 162;
    } else {
        if ((indexPath.row == 0) && (transformationIndex > 2)) {
            height = 162;
        } else {
            height = 44;
        }
    }
    
    return height;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [headers objectAtIndex:section];
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

- (IBAction)textFieldEdited:(id)sender
{
    [self enableSaveButton];
    if (transformationIndex == 1) {
        lineString = textField.text;
        [transformation setObject:lineString forKey:@"line"];
    } else {
        detail = [textField.text floatValue];
        [transformation setObject:[NSNumber numberWithFloat:detail] forKey:@"detail"];
    }
}

#pragma mark - Picker View Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rows;
    
    if (pickerView == transformationTypePicker) {
        rows = [transformationTypes count];
    } else {
        rows = [axisTypes count];
    }
    
    return rows;
}

#pragma mark - Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    
    if (pickerView == transformationTypePicker) {
        title = [transformationTypes objectAtIndex:row];
    } else {
        title = [axisTypes objectAtIndex:row];
    }
    
    return title;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 25;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == transformationTypePicker) {
        transformationIndex = row;
        [transformation setObject:[NSNumber numberWithInteger:transformationIndex] forKey:@"type"];
        [transformation setObject:[NSString stringWithFormat:@"%@", [transformationTypes objectAtIndex:transformationIndex]] forKey:@"typeString"];
    } else {
        axisIndex = row;
        [transformation setObject:[NSNumber numberWithInteger:axisIndex] forKey:@"axis"];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Validation checks

- (BOOL)checkIfLineIsValid
{
    BOOL check = FALSE;
    
    UIAlertView *invalidLine = [[UIAlertView alloc] initWithTitle:@"Validation error" message:@"Please enter a valid equation" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];
    
    if (([[textField.text substringToIndex:1] isEqualToString:@"y"]) || ([[textField.text substringToIndex:1] isEqualToString:@"x"])) {
        check = TRUE;
    } else {
        [invalidLine show];
        check = FALSE;
        textField.text = @"";
    }
    
    return check;
}

- (BOOL)checkIfIntegerIsValid
{
    BOOL check = TRUE;
    
    UIAlertView *invalidInt = [[UIAlertView alloc] initWithTitle:@"Validation error" message:@"Please enter a valid integer" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];
    
    NSScanner *scan = [NSScanner scannerWithString:textField.text];
    if (![scan scanInt:NULL]) {
        check = FALSE;
        [invalidInt show];
        textField.text = @"";
    }
    
    return check;
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
