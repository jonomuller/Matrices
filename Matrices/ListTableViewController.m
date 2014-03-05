//
//  ListTableViewController.m
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import "ListTableViewController.h"

@interface ListTableViewController ()
{
    Matrix *matrix;
}

@end

@implementation ListTableViewController

@synthesize matrices;

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
    
    matrix = [[Matrix alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButton:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [self.delegate passBackMatricesArray:matrices];
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
    return [matrices count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    matrix = [matrices objectAtIndex:indexPath.row];
    
    cell.textLabel.text = matrix.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d x %d", matrix.row, matrix.column];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    [matrices removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITableViewCell *cell = (UITableViewCell*)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    matrix = [matrices objectAtIndex:indexPath.row];
    NSString *title = matrix.name;
    
    MatrixTableViewController *controller = [segue destinationViewController];
    controller.delegate = self;
    controller.navigationItem.title = title;
    controller.indexPathRow = indexPath.row;
    controller.matrices = matrices;
    controller.fromButton = NO;
}

#pragma mark - Delegate methods

- (void)passBackMatricesArray:(NSMutableArray *)array
{
    matrices = array;
}

#pragma mark - Add button

- (void)addButton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MatrixTableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"matrixController"];
    controller.delegate = self;
    controller.title = @"Add matrix";
    controller.matrices = matrices;
    controller.fromButton = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


@end
