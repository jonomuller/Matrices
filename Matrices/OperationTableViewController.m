//
//  OperationTableViewController.m
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import "OperationTableViewController.h"

@interface OperationTableViewController ()
{
    Matrix *matrix;
}

@end

@implementation OperationTableViewController

@synthesize operations, selectedOperation, listOfOperations, listOfMatrices, operationTitle, delegate, matrices, names, headers, operationIndex, firstMatrixIndex, secondMatrixIndex;

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
    
    operations = [[NSMutableArray alloc] initWithObjects:@"Addition", @"Subtraction", @"Multiplication", @"Find determinant", @"Find inverse", nil];
    
    listOfOperations = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    listOfOperations.delegate = self;
    
    listOfMatrices = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    listOfMatrices.delegate = self;
    
    operationTitle = [NSString stringWithFormat:@"Selected operation: %@", selectedOperation];
    
    names = [[NSMutableArray alloc] init];
    
    headers = [[NSMutableArray alloc] initWithObjects:@"Choose operation", @"Choose matrices", nil];
    
    if ([matrices count] > 0) {
        for (int i = 0; i < [matrices count]; i++) {
            matrix = [matrices objectAtIndex:i];
            [names addObject:matrix.name];
        }
    } else {
        matrix = [[Matrix alloc] init];
    }
    
    [listOfOperations selectRow:[operations indexOfObject:selectedOperation] inComponent:0 animated:YES];
    [listOfMatrices selectRow:firstMatrixIndex inComponent:0 animated:YES];
    if (operationIndex < 3) {
        [listOfMatrices selectRow:secondMatrixIndex inComponent:2 animated:YES];
    }
}

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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (indexPath.section == 0) {
        [cell addSubview:listOfOperations];
    } else {
        [cell addSubview:listOfMatrices];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (operationIndex > 2) {
        [headers replaceObjectAtIndex:1 withObject:@"Choose matrix"];
    } else {
        [headers replaceObjectAtIndex:1 withObject:@"Choose matrices"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 162;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [headers objectAtIndex:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *footer;
    if (section == 0) {
        footer = operationTitle;
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

#pragma mark - Picker View Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger components;
    if (pickerView == listOfOperations) {
        components = 1;
    } else {
        components = 3;
        if (operationIndex > 2) {
            components = 1;
        }
    }
    return components;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rows = 0;
    if (pickerView == listOfOperations) {
        rows = [operations count];
    } else {
        if ([names count] != 0) {
            if (component == 1) {
                rows = 1;
            } else {
                rows = [names count];
            }
        }
    }
    return rows;
}

#pragma mark - Picker View Delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat width = 0;
    if (pickerView == listOfOperations) {
        width = 300;
    } else {
        if (component == 1) {
            width = 22;
        } else {
            width = 135;
        }
    }
    return width;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    NSArray *symbols = @[@"+",@"-",@"x"];
    if (pickerView == listOfOperations) {
        title = [operations objectAtIndex:row];
    } else {
        title = [names objectAtIndex:row];
        if (([pickerView numberOfComponents] == 3) && (component == 1)) {
            switch (operationIndex) {
                case 0:
                    title = [symbols objectAtIndex:0];
                    break;
                case 1:
                    title = [symbols objectAtIndex:1];
                    break;
                case 2:
                    title = [symbols objectAtIndex:2];
                    break;
                default:
                    break;
            }
        }
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == listOfOperations) {
        operationTitle = [NSString stringWithFormat:@"Selected operation: %@", [operations objectAtIndex:row]];
        selectedOperation = [operations objectAtIndex:row];
        [self.delegate passBackOperation:selectedOperation];
        operationIndex = row;
        [self.delegate passBackOperationIndex:operationIndex];
        [listOfMatrices reloadAllComponents];
    } else {
        if ([names count] != 0) {
            if (component == 0) {
                firstMatrixIndex = row;
                [self.delegate passBackFirstIndex:firstMatrixIndex];
            } else {
                secondMatrixIndex = row;
                [self.delegate passBackSecondIndex:secondMatrixIndex];
            }
        }
    }
    [self.tableView reloadData];
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
