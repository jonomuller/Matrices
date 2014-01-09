//
//  MasterViewController.m
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

@synthesize options, selectedOperation, matrices;

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
    
    self.title = @"Home";
    
    options = [[NSMutableArray alloc] initWithObjects:@"Initialise matrices", @"Operation", @"Calculate", nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
    
    // Configure the cell...
    
    cell.textLabel.text = [options objectAtIndex:indexPath.row];
    
    if (i == 0) {
        selectedOperation = @"Addition";
    }
    
    i++;
    
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = selectedOperation;
    } else {
        cell.detailTextLabel.text = @"";
    }
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ListTableViewController *controller1 = [storyboard instantiateViewControllerWithIdentifier:@"controller1"];
    OperationTableViewController *controller2 = [storyboard instantiateViewControllerWithIdentifier:@"controller2"];
    CalculateViewController *controller3 = [storyboard instantiateViewControllerWithIdentifier:@"controller3"];
    
    switch (indexPath.row) {
        case 0:
            controller1.title = [options objectAtIndex:0];
            controller1.delegate = self;
            controller1.matrices = matrices;
            [self.navigationController pushViewController:controller1 animated:YES];
            break;
        case 1:
            controller2.title = [options objectAtIndex:1];
            controller2.delegate = self;
            controller2.selectedOperation = selectedOperation;
            controller2.matrices = matrices;
            [self.navigationController pushViewController:controller2 animated:YES];
            break;
        case 2:
            controller3.title = [options objectAtIndex:2];
            [self.navigationController pushViewController:controller3 animated:YES];
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

- (void)passBackOperation:(NSString *)operation
{
    selectedOperation = operation;
}

- (void)passBackMatricesArray:(NSMutableArray *)array
{
    matrices = array;
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
