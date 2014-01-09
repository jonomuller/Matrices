//
//  ListTableViewController.h
//  Matrices
//
//  Created by Jono Muller on 08/01/2014.
//  Copyright (c) 2014 Jonathan Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatrixTableViewController.h"
#import "Matrix.h"

@protocol ListTableViewDelegate <NSObject>

- (void)passBackMatricesArray:(NSMutableArray *)array;

@end

@interface ListTableViewController : UITableViewController <MatrixTableViewDelegate>

@property (strong, nonatomic) id <ListTableViewDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *matrices;

- (IBAction)addButton:(id)sender;

@end
