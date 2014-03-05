//
//  TransformationMasterViewController.h
//  Test
//
//  Created by Jono Muller on 31/01/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphViewController.h"
#import "ListTableViewController.h"
#import "SelectTableViewController.h"
#import "AppDelegate.h"
#import "TransformationListTableViewController.h"
#import "SelectTableViewController.h"
#import "OutputTableViewController.h"
#import "Matrix.h"

@interface TransformationMasterViewController : UITableViewController <ListTableViewDelegate, TransformationListTableViewDelegate, SelectTableViewDelegate, OutputTableViewDelegate>

@property (strong, nonatomic) NSMutableArray *options, *matrices, *transformations;

@property (nonatomic) NSInteger selectedType, selectedInput;

@property (strong, nonatomic) Matrix *matrix;

@end
