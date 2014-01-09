//
//  MasterViewController.h
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListTableViewController.h"
#import "OperationTableViewController.h"
#import "CalculateViewController.h"

@interface MasterViewController : UITableViewController <OperationViewDelegate, ListTableViewDelegate>
{
    NSInteger i;
}

@property (strong, nonatomic) NSMutableArray *options;
@property (strong, nonatomic) NSString *selectedOperation;

@property (strong, nonatomic) NSMutableArray *matrices;

@end
