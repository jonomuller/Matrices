//
//  CalculateTableViewController.m
//  Test
//
//  Created by Jono Muller on 12/01/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import "CalculateTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CalculateTableViewController ()

@end

@implementation CalculateTableViewController

@synthesize headers, matrices, operationIndex, firstMatrixIndex, secondMatrixIndex, leftBracket1, leftBracket2, leftBracket3, rightBracket1, rightBracket2, rightBracket3, label1, label2, label3, label4, label5, label6, label7, label8, label9, label10, label11, label12, label13, label14, label15, label16, label17, label18, opLabel, label19, label20, label21, label22, label23, label24, label25, label26, label27, currentRow1, currentColumn1, currentRow2, currentColumn2, currentPos, finalRow, finalColumn, calculationString, detBracketLeft, detBracketRight, detLabel1, detLabel2, detLabel3, detLabel4, detCalculation, determinantAnswer;

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next step" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep:)];
    
    headers = [[NSMutableArray alloc] initWithObjects:@"Matrices", @"Calcuation", @"Final matrix", nil];
    
    if (operationIndex == 3) {
        headers = [[NSMutableArray alloc] initWithObjects:@"Matrix", @"Calcuation", @"Final answer", nil];
    } else if (operationIndex == 4) {
        if (firstMatrix.row == 3) {
            headers = [[NSMutableArray alloc] initWithObjects:@"Matrix", @"Calculation", @"Cofactors", nil];
        } else {
            headers = [[NSMutableArray alloc] initWithObjects:@"Matrix", @"Calculation", @"Inverse", nil];
        }
    } else {
        headers = [[NSMutableArray alloc] initWithObjects:@"Matrices", @"Calcuation", @"Final matrix", nil];
    }
    
    UIAlertView *noMatrices = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter at least one matrix first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];
    
    UIAlertView *operationError = [[UIAlertView alloc] initWithTitle:@"Cannot perform operation" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];

    firstMatrix = [[Matrix alloc] init];
    secondMatrix = [[Matrix alloc] init];
    
    if (operationIndex == 2) {
        operationError.message = @"Please make sure the number of columns in matrix A is equal to the number of columns in matrix B";
        if (!(firstMatrix.column == secondMatrix.row)) {
            [operationError show];
        }
    } else if (operationIndex < 2) {
        operationError.message = @"Please make sure both matrices have the same number of rows and columns";
        if (!((firstMatrix.row == secondMatrix.row) && (firstMatrix.column == secondMatrix.column))) {
            [operationError show];
        }
    }
    
    if ([matrices count] == 0) {
        [noMatrices show];
    } else {
        firstMatrix = [matrices objectAtIndex:firstMatrixIndex];
        secondMatrix = [matrices objectAtIndex:secondMatrixIndex];
    }
    
    finalMatrix = [[Matrix alloc] init];
    
    if (operationIndex == 2) {
        finalMatrix.row = firstMatrix.row;
        finalMatrix.column = secondMatrix.column;
    } else {
        finalMatrix.row = firstMatrix.row;
        finalMatrix.column = firstMatrix.column;
    }
    
    [finalMatrix initialise];
    
    int leftMatrixPos = 0, rightMatrixPos = 0;
    
    if (((secondMatrix.row > firstMatrix.row)) && ((firstMatrix.row == 3) || (secondMatrix.row == 3))) {
        leftMatrixPos = 7 + ((secondMatrix.row - 1) * 16) - ((firstMatrix.row - 1) * 16);
    } else {
        leftMatrixPos = 7;
    }
    
    if (((firstMatrix.row > secondMatrix.row)) && ((firstMatrix.row == 3) || (secondMatrix.row == 3))) {
        rightMatrixPos = 7 + ((firstMatrix.row - 1) * 16) - ((secondMatrix.row - 1) * 16);
    } else {
        rightMatrixPos = 7;
    }
    
    leftBracket1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, leftMatrixPos, 20, (firstMatrix.row * 32) - 2)];
    
    rightBracket1 = [[UIImageView alloc] initWithFrame:CGRectMake(60 + ((firstMatrix.column - 1) * 32), leftMatrixPos, 20, (firstMatrix.row * 32) - 2)];
    
    if (operationIndex == 3) {
        leftBracket1.image = [UIImage imageNamed:@"detBracket.png"];
        rightBracket1.image = [UIImage imageNamed:@"detBracket.png"];
    } else {
        leftBracket1.image = [UIImage imageNamed:@"leftBracket.png"];
        rightBracket1.image = [UIImage imageNamed:@"rightBracket.png"];
    }
    
    leftBracket2 = [[UIImageView alloc] initWithFrame:CGRectMake(114 + ((firstMatrix.column - 1) * 32), rightMatrixPos, 20, (secondMatrix.row * 32) - 2)];
    leftBracket2.image = [UIImage imageNamed:@"leftBracket.png"];

    rightBracket2 = [[UIImageView alloc] initWithFrame:CGRectMake(164 + ((firstMatrix.column - 1) * 32) + ((secondMatrix.column - 1) * 32), rightMatrixPos, 20, (secondMatrix.row * 32) - 2)];
    rightBracket2.image = [UIImage imageNamed:@"rightBracket.png"];

    leftBracket3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, leftMatrixPos, 20, (finalMatrix.row * 32) - 2)];
    leftBracket3.image = [UIImage imageNamed:@"leftBracket.png"];
    
    rightBracket3 = [[UIImageView alloc] initWithFrame:CGRectMake(60 + ((finalMatrix.column - 1) * 32), leftMatrixPos, 20, (finalMatrix.row * 32) - 2)];
    rightBracket3.image = [UIImage imageNamed:@"rightBracket.png"];
    
    int opLabelPos = 0;
    if (firstMatrix.row > secondMatrix.row) {
        opLabelPos = 7 + ((firstMatrix.row - 1) * 16);
    } else {
        opLabelPos = 7 + ((secondMatrix.row - 1) * 16);
    }
    
    opLabel = [[UILabel alloc] initWithFrame:CGRectMake(82 + ((firstMatrix.column - 1) * 32), opLabelPos, 30, 30)];
    opLabel.backgroundColor = [UIColor whiteColor];
    switch (operationIndex) {
        case 0:
            opLabel.text = @"+";
            break;
        case 1:
            opLabel.text = @"-";
            break;
        case 2:
            opLabel.text = @"x";
            break;
        default:
            opLabel.text = @"";
            break;
    }
    opLabel.textAlignment = NSTextAlignmentCenter;
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, leftMatrixPos, 30, 30)];
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(62, leftMatrixPos, 30, 30)];
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(94, leftMatrixPos, 30, 30)];
    label4 = [[UILabel alloc] initWithFrame:CGRectMake(30, leftMatrixPos + 32, 30, 30)];
    label5 = [[UILabel alloc] initWithFrame:CGRectMake(62, leftMatrixPos + 32, 30, 30)];
    label6 = [[UILabel alloc] initWithFrame:CGRectMake(94, leftMatrixPos + 32, 30, 30)];
    label7 = [[UILabel alloc] initWithFrame:CGRectMake(30, leftMatrixPos + 64, 30, 30)];
    label8 = [[UILabel alloc] initWithFrame:CGRectMake(62, leftMatrixPos + 64, 30, 30)];
    label9 = [[UILabel alloc] initWithFrame:CGRectMake(94, leftMatrixPos + 64, 30, 30)];

    label10 = [[UILabel alloc] initWithFrame:CGRectMake(134 + ((firstMatrix.column - 1) * 32), rightMatrixPos, 30, 30)];
    label11 = [[UILabel alloc] initWithFrame:CGRectMake(166 + ((firstMatrix.column - 1) * 32), rightMatrixPos, 30, 30)];
    label12 = [[UILabel alloc] initWithFrame:CGRectMake(198 + ((firstMatrix.column - 1) * 32), rightMatrixPos, 30, 30)];
    label13 = [[UILabel alloc] initWithFrame:CGRectMake(134 + ((firstMatrix.column - 1) * 32), rightMatrixPos + 32, 30, 30)];
    label14 = [[UILabel alloc] initWithFrame:CGRectMake(166 + ((firstMatrix.column - 1) * 32), rightMatrixPos + 32, 30, 30)];
    label15 = [[UILabel alloc] initWithFrame:CGRectMake(198 + ((firstMatrix.column - 1) * 32), rightMatrixPos + 32, 30, 30)];
    label16 = [[UILabel alloc] initWithFrame:CGRectMake(134 + ((firstMatrix.column - 1) * 32), rightMatrixPos + 64, 30, 30)];
    label17 = [[UILabel alloc] initWithFrame:CGRectMake(166 + ((firstMatrix.column - 1) * 32), rightMatrixPos + 64, 30, 30)];
    label18 = [[UILabel alloc] initWithFrame:CGRectMake(198 + ((firstMatrix.column - 1) * 32), rightMatrixPos + 64, 30, 30)];
    
    label19 = [[UILabel alloc] initWithFrame:CGRectMake(30, leftMatrixPos, 30, 30)];
    label20 = [[UILabel alloc] initWithFrame:CGRectMake(62, leftMatrixPos, 30, 30)];
    label21 = [[UILabel alloc] initWithFrame:CGRectMake(94, leftMatrixPos, 30, 30)];
    label22 = [[UILabel alloc] initWithFrame:CGRectMake(30, leftMatrixPos + 32, 30, 30)];
    label23 = [[UILabel alloc] initWithFrame:CGRectMake(62, leftMatrixPos + 32, 30, 30)];
    label24 = [[UILabel alloc] initWithFrame:CGRectMake(94, leftMatrixPos + 32, 30, 30)];
    label25 = [[UILabel alloc] initWithFrame:CGRectMake(30, leftMatrixPos + 64, 30, 30)];
    label26 = [[UILabel alloc] initWithFrame:CGRectMake(62, leftMatrixPos + 64, 30, 30)];
    label27 = [[UILabel alloc] initWithFrame:CGRectMake(94, leftMatrixPos + 64, 30, 30)];
    
    detBracketLeft = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 20, 62)];
    detBracketLeft.image = [UIImage imageNamed:@"detBracket.png"];
    
    detLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 7, 30, 30)];
    detLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(62, 7, 30, 30)];
    detLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(30, 39, 30, 30)];
    detLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(62, 39, 30, 30)];
    detCalculation = [[UILabel alloc] initWithFrame:CGRectMake(113, 0, 205, 76)];
    detCalculation.numberOfLines = 0;
    
    detBracketRight = [[UIImageView alloc] initWithFrame:CGRectMake(92, 7, 20, 62)];;
    detBracketRight.image = [UIImage imageNamed:@"detBracket.png"];
    
    NSArray *detLabels = @[detLabel1, detLabel2, detLabel3, detLabel4];
    
    for (UILabel *label in detLabels) {
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
    }
    
    allLabels = @[label1, label2, label3, label4, label5, label6, label7, label8, label9, label10, label11, label12, label13, label14, label15, label16, label17, label18, opLabel, label19, label20, label21, label22, label23, label24, label25, label26, label27];
    
    firstLabels = @[label1, label2, label3, label4, label5, label6, label7, label8, label9];
    secondLabels = @[label10, label11, label12, label13, label14, label15, label16, label17, label18];
    finalLabels = @[label19, label20, label21, label22, label23, label24, label25, label26, label27];
    
    firstRow = @[label1, label2, label3];
    secondRow = @[label4, label5, label6];
    thirdRow = @[label7, label8, label9];
    
    for (UILabel *label in allLabels) {
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
    }
    
    for (int i = 0; i < firstMatrix.column; i++) {
        UITextField *field1 = [firstRow objectAtIndex:i];
        UITextField *field2 = [secondRow objectAtIndex:i];
        UITextField *field3 = [thirdRow objectAtIndex:i];
        switch (firstMatrix.row) {
            case 1:
                field1.text = [NSString stringWithFormat:@"%@", [[firstMatrix.elements objectAtIndex:0] objectAtIndex:i]];
                [[firstRow objectAtIndex:i] setHidden:NO];
                for (int j = firstMatrix.column; j < 3; j++) {
                    [[firstRow objectAtIndex:j] setHidden:YES];
                }
                for (int j = 0; j < 3; j++) {
                    [[secondRow objectAtIndex:j] setHidden:YES];
                    [[thirdRow objectAtIndex:j] setHidden:YES];
                }
                break;
            case 2:
                field1.text = [NSString stringWithFormat:@"%@", [[firstMatrix.elements objectAtIndex:0] objectAtIndex:i]];
                field2.text = [NSString stringWithFormat:@"%@", [[firstMatrix.elements objectAtIndex:1] objectAtIndex:i]];
                [[firstRow objectAtIndex:i] setHidden:NO];
                [[secondRow objectAtIndex:i] setHidden:NO];
                for (int j = firstMatrix.column; j < 3; j++) {
                    [[firstRow objectAtIndex:j] setHidden:YES];
                    [[secondRow objectAtIndex:j] setHidden:YES];
                }
                for (int j = 0; j < 3; j++) {
                    [[thirdRow objectAtIndex:j] setHidden:YES];
                }
                break;
            case 3:
                field1.text = [NSString stringWithFormat:@"%@", [[firstMatrix.elements objectAtIndex:0] objectAtIndex:i]];
                field2.text = [NSString stringWithFormat:@"%@", [[firstMatrix.elements objectAtIndex:1] objectAtIndex:i]];
                field3.text = [NSString stringWithFormat:@"%@", [[firstMatrix.elements objectAtIndex:2] objectAtIndex:i]];
                [[firstRow objectAtIndex:i] setHidden:NO];
                [[secondRow objectAtIndex:i] setHidden:NO];
                [[thirdRow objectAtIndex:i] setHidden:NO];
                for (int j = firstMatrix.column; j < 3; j++) {
                    [[firstRow objectAtIndex:j] setHidden:YES];
                    [[secondRow objectAtIndex:j] setHidden:YES];
                    [[thirdRow objectAtIndex:j] setHidden:YES];
                }
                break;
            default:
                break;
        }
    }
    
    firstRow2 = @[label10, label11, label12];
    secondRow2 = @[label13, label14, label15];
    thirdRow2 = @[label16, label17, label18];
    
    for (int i = 0; i < secondMatrix.column; i++) {
        UITextField *field1 = [firstRow2 objectAtIndex:i];
        UITextField *field2 = [secondRow2 objectAtIndex:i];
        UITextField *field3 = [thirdRow2 objectAtIndex:i];
        switch (secondMatrix.row) {
            case 1:
                field1.text = [NSString stringWithFormat:@"%@", [[secondMatrix.elements objectAtIndex:0] objectAtIndex:i]];
                [[firstRow2 objectAtIndex:i] setHidden:NO];
                for (int j = secondMatrix.column; j < 3; j++) {
                    [[firstRow2 objectAtIndex:j] setHidden:YES];
                }
                for (int j = 0; j < 3; j++) {
                    [[secondRow2 objectAtIndex:j] setHidden:YES];
                    [[thirdRow2 objectAtIndex:j] setHidden:YES];
                }
                break;
            case 2:
                field1.text = [NSString stringWithFormat:@"%@", [[secondMatrix.elements objectAtIndex:0] objectAtIndex:i]];
                field2.text = [NSString stringWithFormat:@"%@", [[secondMatrix.elements objectAtIndex:1] objectAtIndex:i]];
                [[firstRow2 objectAtIndex:i] setHidden:NO];
                [[secondRow2 objectAtIndex:i] setHidden:NO];
                for (int j = secondMatrix.column; j < 3; j++) {
                    [[firstRow2 objectAtIndex:j] setHidden:YES];
                    [[secondRow2 objectAtIndex:j] setHidden:YES];
                }
                for (int j = 0; j < 3; j++) {
                    [[thirdRow2 objectAtIndex:j] setHidden:YES];
                }
                break;
            case 3:
                field1.text = [NSString stringWithFormat:@"%@", [[secondMatrix.elements objectAtIndex:0] objectAtIndex:i]];
                field2.text = [NSString stringWithFormat:@"%@", [[secondMatrix.elements objectAtIndex:1] objectAtIndex:i]];
                field3.text = [NSString stringWithFormat:@"%@", [[secondMatrix.elements objectAtIndex:2] objectAtIndex:i]];
                [[firstRow2 objectAtIndex:i] setHidden:NO];
                [[secondRow2 objectAtIndex:i] setHidden:NO];
                [[thirdRow2 objectAtIndex:i] setHidden:NO];
                for (int j = secondMatrix.column; j < 3; j++) {
                    [[firstRow2 objectAtIndex:j] setHidden:YES];
                    [[secondRow2 objectAtIndex:j] setHidden:YES];
                    [[thirdRow2 objectAtIndex:j] setHidden:YES];
                }
                break;
            default:
                break;
        }
    }
    
    NSArray *firstRow3 = @[label19, label20, label21];
    NSArray *secondRow3 = @[label22, label23, label24];
    NSArray *thirdRow3 = @[label25, label26, label27];
    
    int row3 = finalMatrix.row;
    int column3 = finalMatrix.column;
    
    for (int i = 0; i < column3; i++) {
        switch (row3) {
            case 1:
                [[firstRow3 objectAtIndex:i] setHidden:NO];
                for (int j = column3; j < 3; j++) {
                    [[firstRow3 objectAtIndex:j] setHidden:YES];
                }
                for (int j = 0; j < 3; j++) {
                    [[secondRow3 objectAtIndex:j] setHidden:YES];
                    [[thirdRow3 objectAtIndex:j] setHidden:YES];
                }
                break;
            case 2:
                [[firstRow3 objectAtIndex:i] setHidden:NO];
                [[secondRow3 objectAtIndex:i] setHidden:NO];
                for (int j = column3; j < 3; j++) {
                    [[firstRow3 objectAtIndex:j] setHidden:YES];
                    [[secondRow3 objectAtIndex:j] setHidden:YES];
                }
                for (int j = 0; j < 3; j++) {
                    [[thirdRow3 objectAtIndex:j] setHidden:YES];
                }
                break;
            case 3:
                [[firstRow3 objectAtIndex:i] setHidden:NO];
                [[secondRow3 objectAtIndex:i] setHidden:NO];
                [[thirdRow3 objectAtIndex:i] setHidden:NO];
                for (int j = column3; j < 3; j++) {
                    [[firstRow3 objectAtIndex:j] setHidden:YES];
                    [[secondRow3 objectAtIndex:j] setHidden:YES];
                    [[thirdRow3 objectAtIndex:j] setHidden:YES];
                }
                break;
            default:
                break;
        }
    }
    
    NSMutableArray *allBrackets = [[NSMutableArray alloc] initWithObjects:leftBracket1, rightBracket1, leftBracket2, rightBracket2, leftBracket3, rightBracket3, nil];
    
    for (UILabel *element in allLabels) {
        if ([matrices count] == 0) {
            element.hidden = YES;
        }
    }
    
    for (UIImageView *bracket in allBrackets) {
        if ([matrices count] == 0) {
            bracket.hidden = YES;
        }
    }
    
    currentRow1 = 0;
    currentColumn1 = 0;
    currentRow2 = 0;
    currentColumn2 = 0;
    currentPos = 0;
    
    finalRow1 = @[label19, label20, label21];
    finalRow2 = @[label22, label23, label24];
    finalRow3 = @[label25, label26, label27];
    
    finalRows = @[finalRow1, finalRow2, finalRow3];
    
    firstRows = @[firstRow, secondRow, thirdRow];
    secondRows = @[firstRow2, secondRow2, thirdRow2];
    
    if (operationIndex == 3) {
        for (UILabel *label in secondLabels) {
            label.hidden = YES;
        }
        for (UILabel *label in finalLabels) {
            label.hidden = YES;
        }
        opLabel.hidden = YES;
        leftBracket2.hidden = YES;
        rightBracket2.hidden = YES;
        leftBracket3.hidden = YES;
        rightBracket3.hidden = YES;
    } else if (operationIndex == 4) {
        for (UILabel *label in secondLabels) {
            label.hidden = YES;
        }
        opLabel.hidden = YES;
        leftBracket2.hidden = YES;
        rightBracket2.hidden = YES;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [headers objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    
    if (operationIndex == 3) {
        if (indexPath.section == 0) {
            height = 44 + ((firstMatrix.row - 1) * 32);
        } else if (indexPath.section == 1) {
            if (firstMatrix.row == 3) {
                height = 44 + ((firstMatrix.row - 2) * 32);
            } else {
                height = 44;
            }
        } else {
            height = 44;
        }
    } else {
        if (indexPath.section == 1) {
            if (operationIndex == 4) {
                if (firstMatrix.row == 3) {
                    if (currentPos < 10) {
                        height = 44 + ((firstMatrix.row - 2) * 32);
                    } else {
                        height = 44;
                    }
                } else {
                    height = 44;
                }
            } else {
                height = 44;
            }
        } else {
            if ([matrices count] > 0) {
                if (firstMatrix.row > secondMatrix.row) {
                    height = 44 + ((firstMatrix.row - 1) * 32);
                } else {
                    height = 44 + ((secondMatrix.row - 1) * 32);
                }
            } else {
                height = 44;
            }
        }
    }
    return height;
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
        [cell addSubview:leftBracket1];
        [cell addSubview:rightBracket1];
        [cell addSubview:leftBracket2];
        [cell addSubview:rightBracket2];
        for (UILabel *label in allLabels) {
            [cell addSubview:label];
        }
    } else if (indexPath.section == 1) {
//        cell.textLabel.text = calculationString;
        if ((operationIndex > 2) && (firstMatrix.row == 3)) {
            [cell addSubview:detBracketLeft];
            [cell addSubview:detLabel1];
            [cell addSubview:detLabel2];
            [cell addSubview:detLabel3];
            [cell addSubview:detLabel4];
            [cell addSubview:detBracketRight];
            [cell addSubview:detCalculation];
            if (currentPos > 17) {
                cell.textLabel.attributedText = calculationString;
            }
        } else {
            cell.textLabel.attributedText = calculationString;
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            cell.textLabel.numberOfLines = 0;
        }
    } else {
        if (operationIndex == 3) {
            cell.textLabel.attributedText = determinantAnswer;
        } else {
            [cell addSubview:leftBracket3];
            [cell addSubview:rightBracket3];
            for (UILabel *label in finalLabels) {
                [cell addSubview:label];
            }
        }
    }
    
    cell.textLabel.numberOfLines = 0;
    
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

- (void)nextStep:(id)sender
{
    switch (operationIndex) {
        case 0:
            [self performAdditionOrSubtraction];
            break;
        case 1:
            [self performAdditionOrSubtraction];
            break;
        case 2:
            [self performMulitplcation];
            break;
        case 3:
            [self performDeterminant];
            break;
        case 4:
            [self performInverse];
            break;
        default:
            break;
    }
}

- (void)performAdditionOrSubtraction
{
    UILabel *firstLabel = [[firstRows objectAtIndex:currentRow1] objectAtIndex:currentColumn1];
    UILabel *secondLabel = [[secondRows objectAtIndex:currentRow1] objectAtIndex:currentColumn1];
    UILabel *finalLabel = [[finalRows objectAtIndex:currentRow1] objectAtIndex:currentColumn1];
    id currentElement1 = [[firstMatrix.elements objectAtIndex:currentRow1] objectAtIndex:currentColumn1];
    id currentElement2 = [[secondMatrix.elements objectAtIndex:currentRow1] objectAtIndex:currentColumn1];
    
    float finalOutput;
    
    if (operationIndex == 0) {
        finalOutput = [firstMatrix addition:firstMatrix add:secondMatrix row:currentRow1 column:currentColumn1];
        finalLabel.text = [NSString stringWithFormat:@"%.2f", finalOutput];
        calculationString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ + %@ = %.2f", currentElement1, currentElement2, finalOutput]];
    } else {
        finalOutput = [firstMatrix subtraction:firstMatrix subtract:secondMatrix row:currentRow1 column:currentColumn1];
        finalLabel.text = [NSString stringWithFormat:@"%.2f", finalOutput];
        calculationString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ - %@ = %.2f", currentElement1, currentElement2, finalOutput]];
    }
    
    [calculationString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [[NSString stringWithFormat:@"%@", currentElement1] length])];
    [calculationString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(3 + [[NSString stringWithFormat:@"%@", currentElement1] length], [[NSString stringWithFormat:@"%@", currentElement2] length])];
    [calculationString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(6 + [[NSString stringWithFormat:@"%@", currentElement1] length] + [[NSString stringWithFormat:@"%@", currentElement2] length], [finalLabel.text length])];
    
    for (UILabel *label in allLabels) {
        label.textColor = [UIColor blackColor];
    }

    firstLabel.textColor = [UIColor redColor];
    secondLabel.textColor = [UIColor greenColor];
    finalLabel.textColor = [UIColor blueColor];
    
    [self.tableView reloadData];
    
    if ((currentRow1 == (firstMatrix.row - 1)) && (currentColumn1 == (firstMatrix.column - 1))) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    if (currentColumn1 == (firstMatrix.column - 1)) {
        currentRow1++;
        currentColumn1 = 0;
    } else {
        currentColumn1++;
    }
}

- (void)performMulitplcation
{
    UILabel *firstColumn1Label = [[firstRows objectAtIndex:currentRow1] objectAtIndex:currentColumn1];
//    UILabel *firstColumn2Label = [[firstRows objectAtIndex:currentRow1] objectAtIndex:currentColumn1+1];
//    UILabel *firstColumn3Label = [[firstRows objectAtIndex:currentRow1] objectAtIndex:currentColumn1+2];
    UILabel *secondRow1Label = [[secondRows objectAtIndex:currentRow2] objectAtIndex:currentColumn2];
//    UILabel *secondRow2Label = [[secondRows objectAtIndex:currentRow2+1] objectAtIndex:currentColumn2];
//    UILabel *secondRow3Label = [[secondRows objectAtIndex:currentRow2+2] objectAtIndex:currentColumn2];
    UILabel *finalLabel = [[finalRows objectAtIndex:finalRow] objectAtIndex:finalColumn];
    id currentElement1 = [[firstMatrix.elements objectAtIndex:currentRow1] objectAtIndex:currentColumn1];
    id currentElement2 = [[secondMatrix.elements objectAtIndex:currentRow2] objectAtIndex:currentColumn2];
    
    finalLabel.text = [NSString stringWithFormat:@"%.2f", [firstMatrix multiplication:firstMatrix multiply:secondMatrix row1:currentRow1 column1:currentColumn1 row2:currentRow2 column2:currentColumn2 numberOfColumns:firstMatrix.column]];
    switch (firstMatrix.column) {
        case 1:
            calculationString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ x %@ = %.2f", currentElement1, currentElement2, [firstMatrix multiplication:firstMatrix multiply:secondMatrix row1:currentRow1 column1:currentColumn1 row2:currentRow2 column2:currentColumn2 numberOfColumns:firstMatrix.column]]];
            break;
        case 2:
            calculationString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@ x %@) + (%@ x %@) = %.2f", currentElement1, currentElement2, [[firstMatrix.elements objectAtIndex:currentRow1] objectAtIndex:(currentColumn1+1)], [[secondMatrix.elements objectAtIndex:(currentRow2+1)] objectAtIndex:currentColumn2], [firstMatrix multiplication:firstMatrix multiply:secondMatrix row1:currentRow1 column1:currentColumn1 row2:currentRow2 column2:currentColumn2 numberOfColumns:firstMatrix.column]]];
            break;
        case 3:
            calculationString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@ x %@) + (%@ x %@) + (%@ x %@) = %.2f", currentElement1, currentElement2, [[firstMatrix.elements objectAtIndex:currentRow1] objectAtIndex:(currentColumn1+1)], [[secondMatrix.elements objectAtIndex:(currentRow2+1)] objectAtIndex:currentColumn2], [[firstMatrix.elements objectAtIndex:currentRow1] objectAtIndex:(currentColumn1+2)], [[secondMatrix.elements objectAtIndex:currentRow2+2] objectAtIndex:currentColumn2], [firstMatrix multiplication:firstMatrix multiply:secondMatrix row1:currentRow1 column1:currentColumn1 row2:currentRow2 column2:currentColumn2 numberOfColumns:firstMatrix.column]]];
            break;
        default:
            break;
    }
    
    NSInteger firstBracketValue = [[NSString stringWithFormat:@"%@", currentElement1] length] + 3 + [[NSString stringWithFormat:@"%@", currentElement2] length];
    
//    NSInteger secondBracketValue = [[NSString stringWithFormat:@"%@", [[firstMatrix.elements objectAtIndex:currentRow1] objectAtIndex:(currentColumn1+1)]] length] + 3 + [[NSString stringWithFormat:@"%@", [[secondMatrix.elements objectAtIndex:(currentRow2+1)] objectAtIndex:currentColumn2]] length];
    
//    NSInteger thirdBracketValue = [[NSString stringWithFormat:@"%@", [[firstMatrix.elements objectAtIndex:currentRow1] objectAtIndex:(currentColumn1+2)]] length] + 3 + [[NSString stringWithFormat:@"%@", [[secondMatrix.elements objectAtIndex:currentRow2+2] objectAtIndex:currentColumn2]] length];
    
    if (firstMatrix.column == 1) {
        [calculationString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, firstBracketValue)];
        [calculationString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(3 + firstBracketValue, [finalLabel.text length])];
    } else {
        [calculationString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1, firstBracketValue)];
        
        if (firstMatrix.row == 3) {
//            [calculationString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(6 + firstBracketValue, secondBracketValue)];
//            [calculationString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(11 + firstBracketValue + secondBracketValue, thirdBracketValue)];
//            [calculationString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(15 + firstBracketValue + secondBracketValue + thirdBracketValue, [finalLabel.text length])];
        } else if (firstMatrix.row == 2) {
//            [calculationString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(6 + firstBracketValue, secondBracketValue)];
//            [calculationString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(10 + firstBracketValue + secondBracketValue, [finalLabel.text length])];
        }
    }
    
    for (UILabel *label in allLabels) {
        label.textColor = [UIColor blackColor];
    }

    
    firstColumn1Label.textColor = [UIColor redColor];
//    firstColumn2Label.textColor = [UIColor greenColor];
//    firstColumn3Label.textColor = [UIColor orangeColor];
    
    secondRow1Label.textColor = [UIColor redColor];
//    secondRow2Label.textColor = [UIColor greenColor];
//    secondRow3Label.textColor = [UIColor orangeColor];
    
    finalLabel.textColor = [UIColor blueColor];

    [self.tableView reloadData];
    
    if ((finalRow == (finalMatrix.row - 1)) && (finalColumn == (finalMatrix.column - 1))) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    if (currentColumn2 == (secondMatrix.column - 1)) {
        currentRow1++;
        currentColumn2 = 0;
    } else {
        currentColumn2++;
    }
    
    if (finalColumn == (finalMatrix.column - 1)) {
        finalColumn = 0;
        finalRow++;
    } else {
        finalColumn++;
    }
}

- (void)performDeterminant
{
    Matrix *detMatrix;
    if (currentColumn1 < 3) {
        detMatrix = [firstMatrix determinantMatrix:firstMatrix row:0 column:currentColumn1];
    }
    
    Matrix *detMatrix1, *detMatrix2, *detMatrix3;
    
    switch (firstMatrix.row) {
        case 1:
            determinantAnswer = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\u0394 = %.2f", [firstMatrix determinant:firstMatrix]]];
            self.navigationItem.rightBarButtonItem.enabled = NO;
            break;
        case 2:
            calculationString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@ x %@) - (%@ x %@) = %.2f", [[firstMatrix.elements objectAtIndex:0] objectAtIndex:0], [[firstMatrix.elements objectAtIndex:1] objectAtIndex:1], [[firstMatrix.elements objectAtIndex:0] objectAtIndex:1], [[firstMatrix.elements objectAtIndex:1] objectAtIndex:0], [firstMatrix determinant:firstMatrix]]];
            determinantAnswer = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\u0394 = %.2f", [firstMatrix determinant:firstMatrix]]];
            self.navigationItem.rightBarButtonItem.enabled = NO;
            break;
        case 3:
            detMatrix1 = [firstMatrix determinantMatrix:firstMatrix row:0 column:0];
            detMatrix2 = [firstMatrix determinantMatrix:firstMatrix row:0 column:1];
            detMatrix3 = [firstMatrix determinantMatrix:firstMatrix row:0 column:2];
            if (currentColumn1 < 3) {
                detLabel1.text = [NSString stringWithFormat:@"%@", [[detMatrix.elements objectAtIndex:0] objectAtIndex:0]];
                detLabel2.text = [NSString stringWithFormat:@"%@", [[detMatrix.elements objectAtIndex:0] objectAtIndex:1]];
                detLabel3.text = [NSString stringWithFormat:@"%@", [[detMatrix.elements objectAtIndex:1] objectAtIndex:0]];
                detLabel4.text = [NSString stringWithFormat:@"%@", [[detMatrix.elements objectAtIndex:1] objectAtIndex:1]];
                detCalculation.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"= (%@ x %@) - (%@ x %@)\n= %.2f", [[detMatrix.elements objectAtIndex:0] objectAtIndex:0], [[detMatrix.elements objectAtIndex:1] objectAtIndex:1], [[detMatrix.elements objectAtIndex:0] objectAtIndex:1], [[detMatrix.elements objectAtIndex:1] objectAtIndex:0], [detMatrix determinant:detMatrix]]];
            } else {
                determinantAnswer = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@ x %.2f) - (%@ x %.2f) + (%@ x %.2f) = %.2f", [[firstMatrix.elements objectAtIndex:0] objectAtIndex:0], [detMatrix1 determinant:detMatrix1], [[firstMatrix.elements objectAtIndex:0] objectAtIndex:1], [detMatrix2 determinant:detMatrix2], [[firstMatrix.elements objectAtIndex:0] objectAtIndex:2], [detMatrix3 determinant:detMatrix3], [firstMatrix determinant:firstMatrix]]];
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
            break;
        default:
            break;
    }
    
    currentColumn1++;
    
    [self.tableView reloadData];
}

- (void)performInverse
{
    float determinant = [firstMatrix determinant:firstMatrix];
    
    Matrix *inverseMatrix = [[Matrix alloc] init];
    
    Matrix *detMatrix = [[Matrix alloc] init];
    if (firstMatrix.row > 1) {
        detMatrix = [firstMatrix determinantMatrix:firstMatrix row:currentRow1 column:currentColumn1];
    }
    
    Matrix *cofactorMatrix = [[Matrix alloc] init];
    cofactorMatrix.row = firstMatrix.row;
    cofactorMatrix.column = firstMatrix.column;
    [cofactorMatrix initialise];
    
    Matrix *transposedMatrix = [[Matrix alloc] init];
    transposedMatrix.row = firstMatrix.row;
    transposedMatrix.column = firstMatrix.column;
    [transposedMatrix initialise];
    
    if (firstMatrix.row == 3) {
        for (int i = 0; i < cofactorMatrix.row; i++) {
            for (int j = 0; j < cofactorMatrix.column; j++) {
                [[cofactorMatrix.elements objectAtIndex:i] replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:[firstMatrix cofactor:firstMatrix row:i column:j]]];
            }
        }
        
        for (int i = 0; i < transposedMatrix.row; i++) {
            for (int j = 0; j < transposedMatrix.column; j++) {
                [[transposedMatrix.elements objectAtIndex:i] replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:[cofactorMatrix transpose:cofactorMatrix row:i column:j]]];
            }
        }
    }
    
    UILabel *finalLabel = [[finalRows objectAtIndex:currentRow1] objectAtIndex:currentColumn1];
    
    switch (firstMatrix.row) {
        case 1:
            inverseMatrix = [firstMatrix inverse:firstMatrix];
            finalLabel.text = [NSString stringWithFormat:@"%@", [[inverseMatrix.elements objectAtIndex:currentRow1] objectAtIndex:currentColumn1]];
            self.navigationItem.rightBarButtonItem.enabled = NO;
            break;
        case 2:
            if (currentPos == 0) {
                currentRow1 = 0;
                currentColumn1 = -1;
            }
            
            if (currentPos == 0) {
                calculationString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\u0394 = (%@ x %@) - (%@ x %@) = %.2f", [[firstMatrix.elements objectAtIndex:0] objectAtIndex:0], [[firstMatrix.elements objectAtIndex:1] objectAtIndex:1], [[firstMatrix.elements objectAtIndex:0] objectAtIndex:1], [[firstMatrix.elements objectAtIndex:1] objectAtIndex:0], [firstMatrix determinant:firstMatrix]]];
            } else {
                inverseMatrix = [firstMatrix inverse:firstMatrix];
                calculationString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ \u00F7 %.2f = %.2f", [[inverseMatrix.elements objectAtIndex:currentRow1] objectAtIndex:currentColumn1], determinant, [inverseMatrix divideByDeterminant:inverseMatrix row:currentRow1 column:currentColumn1 determinant:determinant]]];
                finalLabel.text = [NSString stringWithFormat:@"%.2f", [inverseMatrix divideByDeterminant:inverseMatrix row:currentRow1 column:currentColumn1 determinant:determinant]];
            }
            
            if (currentPos == 4) {
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
            break;
        case 3:
            if ((currentPos % 9 == 0) && (currentPos > 2)) {
                currentRow1 = 0;
                currentColumn1 = 0;
            }
            if (currentPos < 9) {
                detLabel1.text = [NSString stringWithFormat:@"%@", [[detMatrix.elements objectAtIndex:0] objectAtIndex:0]];
                detLabel2.text = [NSString stringWithFormat:@"%@", [[detMatrix.elements objectAtIndex:0] objectAtIndex:1]];
                detLabel3.text = [NSString stringWithFormat:@"%@", [[detMatrix.elements objectAtIndex:1] objectAtIndex:0]];
                detLabel4.text = [NSString stringWithFormat:@"%@", [[detMatrix.elements objectAtIndex:1] objectAtIndex:1]];
                detCalculation.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"= (%@ x %@) - (%@ x %@)\n= %.2f", [[detMatrix.elements objectAtIndex:0] objectAtIndex:0], [[detMatrix.elements objectAtIndex:1] objectAtIndex:1], [[detMatrix.elements objectAtIndex:0] objectAtIndex:1], [[detMatrix.elements objectAtIndex:1] objectAtIndex:0], [firstMatrix determinant:firstMatrix]]];
                finalLabel.text = [NSString stringWithFormat:@"%.2f", [firstMatrix cofactor:firstMatrix row:currentRow1 column:currentColumn1]];
            } else if (currentPos < 18) {
                
                if (currentPos == 9) {
                    detBracketLeft.hidden = YES;
                    detLabel1.hidden = YES;
                    detLabel2.hidden = YES;
                    detLabel3.hidden = YES;
                    detLabel4.hidden = YES;
                    detBracketRight.hidden = YES;
                    detCalculation.attributedText = [[NSMutableAttributedString alloc] initWithString:@""];
                    for (UILabel *label in finalLabels) {
                        label.text = @"";
                    }
                    [headers replaceObjectAtIndex:2 withObject:@"Transposed"];
                }
                
                [self.tableView reloadData];
                finalLabel.text = [NSString stringWithFormat:@"%.2f", [firstMatrix transpose:cofactorMatrix row:currentRow1 column:currentColumn1]];
            } else if (currentPos < 27) {
                
                if (currentPos == 18) {
                    for (UILabel *label in finalLabels) {
                        label.text = @"";
                    }
                    [headers replaceObjectAtIndex:2 withObject:@"Inverse"];
                }
                
                [self.tableView reloadData];
                
                calculationString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ \u00F7 %.2f = %.2f", [[transposedMatrix.elements objectAtIndex:currentRow1] objectAtIndex:currentColumn1], determinant, [transposedMatrix divideByDeterminant:transposedMatrix row:currentRow1 column:currentColumn1 determinant:determinant]]];
                finalLabel.text = [NSString stringWithFormat:@"%.2f", [transposedMatrix divideByDeterminant:transposedMatrix row:currentRow1 column:currentColumn1 determinant:determinant]];
                
                if (currentPos == 26) {
                    self.navigationItem.rightBarButtonItem.enabled = NO;
                }
            }
            break;
        default:
            break;
    }
    
    if (currentColumn1 == (firstMatrix.column - 1)) {
        currentRow1++;
        currentColumn1 = 0;
    } else {
        currentColumn1++;
    }
    
    currentPos++;
    
    [self.tableView reloadData];
}

#pragma mark - Alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
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
