//
//  TransformationMasterViewController.m
//  Test
//
//  Created by Jono Muller on 31/01/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import "TransformationMasterViewController.h"

@interface TransformationMasterViewController ()

@end

@implementation TransformationMasterViewController

@synthesize options, matrices, selectedType, selectedInput, transformations, matrix;

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Transformations";
    
    options = [[NSMutableArray alloc] initWithObjects:@"Matrices", @"Transformations", @"Select input", @"Output", @"Display on graph", nil];
    
    matrix = [[Matrix alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    matrices = appDelegate.matrices;
    NSLog(@"%@", matrices);
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [options count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    // Configure the cell...
        
    cell.textLabel.text = [options objectAtIndex:indexPath.row];
    
    if (indexPath.row == 2) {
        if (selectedType == 0) {
            cell.detailTextLabel.text = @"Matrix";
        } else {
            cell.detailTextLabel.text = @"Transformation";
        }
    } else if (indexPath.row == 3) {
        cell.detailTextLabel.text = @"";
    } else {
        cell.detailTextLabel.text = @"";
    }
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListTableViewController *controller1 = [storyboard instantiateViewControllerWithIdentifier:@"controller2"];
    TransformationListTableViewController *controller2 = [storyboard instantiateViewControllerWithIdentifier:@"transformationListController"];
    SelectTableViewController *controller3 = [storyboard instantiateViewControllerWithIdentifier:@"selectTransformationController"];
    OutputTableViewController *controller4 = [storyboard instantiateViewControllerWithIdentifier:@"outputController"];
    GraphViewController *controller5 = [storyboard instantiateViewControllerWithIdentifier:@"graphViewController"];
    
    NSMutableDictionary *transformation = [transformations objectAtIndex:selectedInput];
    
    switch (indexPath.row) {
        case 0:
            controller1.title = [options objectAtIndex:indexPath.row];
            controller1.delegate = self;
            controller1.matrices = matrices;
            controller1.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller1 animated:YES];
            break;
        case 1:
            controller2.title = [options objectAtIndex:indexPath.row];
            controller2.delegate = self;
            controller2.hidesBottomBarWhenPushed = YES;
            controller2.transformations = transformations;
            [self.navigationController pushViewController:controller2 animated:YES];
            break;
        case 2:
            controller3.title = [options objectAtIndex:indexPath.row];
            controller3.hidesBottomBarWhenPushed = YES;
            controller3.delegate = self;
            NSLog(@"matrices: %@", matrices);
            controller3.matrices = matrices;
            controller3.transformations = transformations;
            controller3.selectedType = selectedType;
            controller3.selectedInput = selectedInput;
            [self.navigationController pushViewController:controller3 animated:YES];
            break;
        case 3:
            controller4.title = [options objectAtIndex:indexPath.row];
            controller4.hidesBottomBarWhenPushed = YES;
            controller4.matrices = matrices;
            controller4.transformations = transformations;
            controller4.selectedType = selectedType;
            controller4.selectedInput = selectedInput;
            [self.navigationController pushViewController:controller4 animated:YES];
            break;
        case 4:
            controller5.title = [options objectAtIndex:indexPath.row];
            if (selectedType == 1) {
                controller5.matrix = [matrix convertTransformationToMatrix:transformation];
                NSLog(@"name: %@", matrix.elements);
            } else {
                if ([matrices count] > 0) {
                    controller5.matrix = [matrices objectAtIndex:selectedInput];
                }
            }
            controller5.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller5 animated:YES];
            break;
        default:
            break;
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


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


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}

#pragma mark - Delegate methods

- (void)passBackMatricesArray:(NSMutableArray *)array
{
    matrices = array;
}

- (void)passBackSelectedType:(NSInteger)num
{
    selectedType = num;
}

- (void)passBackSelectedInput:(NSInteger)num
{
    selectedInput = num;
}

- (void)passAlongMatrices:(NSMutableArray *)array
{
    matrices = array;
}

- (void)passBackTransformationsArray:(NSMutableArray *)array
{
    transformations = array;
}

//- (void)passBackMatrix:(Matrix *)output
//{
//    matrix = output;
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
