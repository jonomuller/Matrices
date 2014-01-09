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

@synthesize operations, selectedOperation, listOfOperations, listOfMatrices, operationTitle, matricesTitle, delegate, matrices, names, headers;

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
    
    operations = [[NSMutableArray alloc] initWithObjects:@"Addition", @"Subtraction", @"Multiplication", @"Find determinant", @"Find inverse", nil];
    
    listOfOperations = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 161)];
    listOfOperations.delegate = self;
    
    listOfMatrices = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 161)];
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
    
    if ([names count] > 0) {
        matricesTitle = [NSString stringWithFormat:@"%@ %@", [names objectAtIndex:0], [names objectAtIndex:0]];
    }
    
    [listOfOperations selectRow:[operations indexOfObject:selectedOperation] inComponent:0 animated:YES];
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
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 161;
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
    } else {
        footer = matricesTitle;
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
        components = 2;
    }
    return components;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rows;
    if (pickerView == listOfOperations) {
        rows = [operations count];
    } else {
        rows = [names count];
    }
    return rows;
}

#pragma mark - Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    if (pickerView == listOfOperations) {
        title = [operations objectAtIndex:row];
    } else {
        title = [names objectAtIndex:row];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == listOfOperations) {
        operationTitle = [NSString stringWithFormat:@"Selected operation: %@", [operations objectAtIndex:row]];
        [self.delegate passBackOperation:[operations objectAtIndex:row]];
    } else {
        matricesTitle = [NSString stringWithFormat:@"%@ %@", [names objectAtIndex:row], [names objectAtIndex:row]];
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
