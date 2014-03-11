//
//  TransformationListTableViewController.m
//  Test
//
//  Created by Jono Muller on 05/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import "TransformationListTableViewController.h"

@interface TransformationListTableViewController ()

@end

@implementation TransformationListTableViewController

@synthesize transformations, transformation;

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButton:)];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [self.delegate passBackTransformationsArray:transformations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EnterTransformationTableViewController *controller1 = [storyboard instantiateViewControllerWithIdentifier:@"transformationController"];
    controller1.delegate = self;
    controller1.title = @"Add transformation";
    controller1.transformations = transformations;
    controller1.fromButton = YES;
    [self.navigationController pushViewController:controller1 animated:YES];
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
    return [transformations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    transformation = [transformations objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [transformation objectForKey:@"typeString"]];
    
    NSArray *axes = @[@"x", @"y"];
    NSInteger axisPos = [[transformation objectForKey:@"axis"] integerValue];
    
    switch ([[transformation objectForKey:@"type"] integerValue]) {
        case 0:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\u00B0", [transformation objectForKey:@"detail"]];
            break;
        case 1:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [transformation objectForKey:@"line"]];
            break;
        case 2:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"s.f. %@", [transformation objectForKey:@"detail"]];
            break;
        case 3:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@: s.f. %@", [axes objectAtIndex:axisPos], [transformation objectForKey:@"detail"]];
            break;
        case 4:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@: s.f. %@", [axes objectAtIndex:axisPos], [transformation objectForKey:@"detail"]];
            break;
        default:
            break;
    }
    
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
    [transformations removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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

#pragma mark - Delegate methods

- (void)passBackTransformationsArray:(NSMutableArray *)array
{
    transformations = array;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITableViewCell *cell = (UITableViewCell*)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    transformation = [transformations objectAtIndex:indexPath.row];
    
    NSString *title = [NSString stringWithFormat:@"%@", [transformation objectForKey:@"typeString"]];
    
    EnterTransformationTableViewController *enterTransformationController = [segue destinationViewController];
    enterTransformationController.delegate = self;
    enterTransformationController.navigationItem.title = title;
    enterTransformationController.indexPathRow = indexPath.row;
    enterTransformationController.transformations = transformations;
    enterTransformationController.fromButton = NO;
}


@end
