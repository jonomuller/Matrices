//
//  OutputTableViewController.m
//  Test
//
//  Created by Jono Muller on 27/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import "OutputTableViewController.h"

@interface OutputTableViewController ()

@end

@implementation OutputTableViewController

@synthesize headers, transformations, selectedInput, selectedType, matrices, matrix, transformation, outputMatrix, outputTransformation, delegate;

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
    
    NSLog(@"%d", selectedType);
    
    if (selectedType == 0) {
        headers = [[NSMutableArray alloc] initWithObjects:@"Matrix", @"Transformation output", nil];
    } else {
        headers = [[NSMutableArray alloc] initWithObjects:@"Transformation", @"Matrix ouput", nil];
    }
    
    if (selectedType == 0) {
        if ([matrices count] > 0) {
            matrix = [matrices objectAtIndex:selectedInput];
        }
    } else {
        matrix = [[Matrix alloc] init];
    }

    if (selectedType == 0) {
        transformation = [[NSMutableDictionary alloc] init];
    } else {
        if ([transformations count] > 0) {
            transformation = [transformations objectAtIndex:selectedInput];
        }
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSLog(@"%@", matrix.elements);
    
    if (selectedType == 0) {
        transformation = [matrix convertMatrixToTransformation:matrix];
    } else {
        matrix = [matrix convertTransformationToMatrix:transformation];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    if (selectedType == 0) {
        if (indexPath.section == 0) {
            height = 76;
        } else {
            height = 44;
        }
    } else {
        if (indexPath.section == 0) {
            height = 44;
        } else {
            height = 76;
        }
    }
    
    return height;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [headers objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    UIImageView *leftBracket = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 20, 62)];
    leftBracket.image = [UIImage imageNamed:@"leftBracket.png"];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 7, 30, 30)];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(62, 7, 30, 30)];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(30, 39, 30, 30)];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(62, 39, 30, 30)];
    
    UIImageView *rightBracket = [[UIImageView alloc] initWithFrame:CGRectMake(92, 7, 20, 62)];
    rightBracket.image = [UIImage imageNamed:@"rightBracket.png"];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
//    formatter.maximumSignificantDigits = 3;
//    formatter.usesSignificantDigits = YES;
    
    [formatter setPaddingCharacter:@"0"];
    
    label1.text = [NSString stringWithFormat:@"%@", [formatter stringForObjectValue:[[matrix.elements objectAtIndex:0] objectAtIndex:0]]];
    label2.text = [NSString stringWithFormat:@"%@", [formatter stringForObjectValue:[[matrix.elements objectAtIndex:0] objectAtIndex:1]]];
    label3.text = [NSString stringWithFormat:@"%@", [formatter stringForObjectValue:[[matrix.elements objectAtIndex:1] objectAtIndex:0]]];
    label4.text = [NSString stringWithFormat:@"%@", [formatter stringForObjectValue:[[matrix.elements objectAtIndex:1] objectAtIndex:1]]];
    
    NSArray *labels = @[label1, label2, label3, label4];
    
    for (UILabel *label in labels) {
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
    }
    
    NSArray *axes = @[@"x", @"y"];
    NSInteger axisPos = [[transformation objectForKey:@"axis"] integerValue];
    
    NSString *title;
    
    switch ([[transformation objectForKey:@"type"] integerValue]) {
        case 0:
            title = [NSString stringWithFormat:@"%@ %@\u00B0", [transformation objectForKey:@"typeString"], [transformation objectForKey:@"detail"]];
            break;
        case 1:
            title = [NSString stringWithFormat:@"%@ in %@", [transformation objectForKey:@"typeString"], [transformation objectForKey:@"line"]];
            break;
        case 2:
            title = [NSString stringWithFormat:@"%@ s.f. %@", [transformation objectForKey:@"typeString"], [transformation objectForKey:@"detail"]];
            break;
        case 3:
            title = [NSString stringWithFormat:@"%@ in %@ s.f. %@", [transformation objectForKey:@"typeString"],[axes objectAtIndex:axisPos], [transformation objectForKey:@"detail"]];
            break;
        case 4:
            title = [NSString stringWithFormat:@"%@ in %@ s.f. %@", [transformation objectForKey:@"typeString"], [axes objectAtIndex:axisPos], [transformation objectForKey:@"detail"]];
            break;
        default:
            break;
    }
    
    if (selectedType == 1) {
        matrix.name = title;
    }
    
    if (selectedType == 0) {
        if (indexPath.section == 0) {
            [cell addSubview:leftBracket];
            for (UILabel *label in labels) {
                [cell addSubview:label];
            }
            [cell addSubview:rightBracket];
        } else {
            cell.textLabel.text = title;
        }
    } else {
        if (indexPath.section == 0) {
            cell.textLabel.text = title;
        } else {
            [cell addSubview:leftBracket];
            for (UILabel *label in labels) {
                [cell addSubview:label];
            }
            [cell addSubview:rightBracket];
        }
    }
    
    [self.delegate passBackMatrix:matrix];
    
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
