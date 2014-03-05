//
//  MasterViewController.h
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "OperationTableViewController.h"
#import "MatrixTableViewController.h"
#import "ListTableViewController.h"
#import "TransformationMasterViewController.h"
#import "CalculateTableViewController.h"
#import "AppDelegate.h"

@interface MasterViewController : UITableViewController <OperationViewDelegate, ListTableViewDelegate>
{
    NSInteger i;
}

@property (strong, nonatomic) NSMutableArray *options;
@property (strong, nonatomic) NSString *selectedOperation;

@property (strong, nonatomic) NSMutableArray *matrices;

@property (nonatomic) NSInteger operationIndex;
@property (nonatomic) NSInteger firstMatrixIndex;
@property (nonatomic) NSInteger secondMatrixIndex;

@end
