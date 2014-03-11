//
//  SelectTableViewController.m
//  Test
//
//  Created by Jono Muller on 03/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import "SelectTableViewController.h"

@interface SelectTableViewController ()

@end

@implementation SelectTableViewController

@synthesize typePicker, inputPicker, headers, types, transformations, matrices, selectedType, selectedInput, matrix, transformation, matrixNames, transformationNames, transformationTypes;

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
    
    if (selectedType == 0)
        headers = [[NSMutableArray alloc] initWithObjects:@"Choose operation", @"Choose matrix", nil];
    else {
        headers = [[NSMutableArray alloc] initWithObjects:@"Choose operation", @"Choose transformation", nil];
    }
    
    types = [[NSMutableArray alloc] initWithObjects:@"Matrix to transformation", @"Transformation to matrix", nil];
    
    transformationTypes = [[NSMutableArray alloc] initWithObjects:@"Rotation", @"Reflection", @"Enlargement", @"Stretch", @"Shear", nil];
    
    typePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    typePicker.delegate = self;
    
    [typePicker selectRow:selectedType inComponent:0 animated:YES];
    
    inputPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    inputPicker.delegate = self;
    
    matrixNames = [[NSMutableArray alloc] init];
    transformationNames = [[NSMutableArray alloc] init];
    
    if ([matrices count] > 0) {
        for (int i = 0; i < [matrices count]; i++) {
            matrix = [matrices objectAtIndex:i];
            [matrixNames addObject:matrix.name];
        }
    } else {
        matrix = [[Matrix alloc] init];
    }
    
    if ([transformations count] > 0) {
        for (int i = 0; i < [transformations count]; i++) {
            transformation = [transformations objectAtIndex:i];
            
            NSArray *axes = @[@"x", @"y"];
            NSInteger axisPos = [[transformation objectForKey:@"axis"] integerValue];
            
            NSInteger position = [[transformation objectForKey:@"type"] integerValue];
            NSString *string;
            
            switch (position) {
                case 0:
                    string = [NSString stringWithFormat:@"%@ %@\u00B0", [transformationTypes objectAtIndex:position], [transformation objectForKey:@"detail"]];
                    break;
                case 1:
                    string = [NSString stringWithFormat:@"%@ %@", [transformationTypes objectAtIndex:position], [transformation objectForKey:@"line"]];
                    break;
                case 2:
                    string = [NSString stringWithFormat:@"%@ s.f. %@", [transformationTypes objectAtIndex:position], [transformation objectForKey:@"detail"]];
                    break;
                case 3:
                    string = [NSString stringWithFormat:@"%@ s.f. %@", [transformationTypes objectAtIndex:position], [transformation objectForKey:@"detail"]];
                    break;
                case 4:
                    string = [NSString stringWithFormat:@"%@ %@: s.f. %@", [transformationTypes objectAtIndex:position], [axes objectAtIndex:axisPos], [transformation objectForKey:@"detail"]];
                    break;
                default:
                    break;
            }
            
//            NSString *string = [NSString stringWithFormat:@"%@", [transformationTypes objectAtIndex:position]];
            [transformationNames addObject:string];
        }
    } else {
        transformation = [[NSMutableDictionary alloc] init];
    }
    
    [inputPicker selectRow:selectedInput inComponent:0 animated:YES];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    NSLog(@"%@", matrixNames);
    
    self.navigationController.navigationBar.translucent = NO;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [headers objectAtIndexedSubscript:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 162;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
 
    // Configure the cell...
    
    if (indexPath.section == 0) {
        [cell addSubview:typePicker];
    } else {
        [cell addSubview:inputPicker];
    }
    
    return cell;
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
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rows;
    
    if (pickerView == typePicker) {
        rows = [types count];
    } else {
        if (selectedType == 0) {
            rows = [matrixNames count];
        } else {
            rows = [transformationNames count];
        }
    }
    
    return rows;
}

#pragma mark - Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    
    if (pickerView == typePicker) {
        title = [types objectAtIndex:row];
    } else {
        if (selectedType == 0) {
            title = [matrixNames objectAtIndex:row];
        } else {
            title = [transformationNames objectAtIndex:row];
        }
    }
    
    return title;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 25;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == typePicker) {
        selectedType = row;
        [inputPicker reloadAllComponents];
        if (selectedType == 0) {
            [headers replaceObjectAtIndex:1 withObject:@"Choose matrices"];
        } else {
            [headers replaceObjectAtIndex:1 withObject:@"Choose transformations"];
        }
        [self.delegate passBackSelectedType:selectedType];
    } else {
        selectedInput = row;
        [self.delegate passBackSelectedInput:selectedInput];
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
