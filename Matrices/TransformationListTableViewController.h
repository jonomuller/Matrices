//
//  TransformationListTableViewController.h
//  Test
//
//  Created by Jono Muller on 05/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnterTransformationTableViewController.h"

@protocol TransformationListTableViewDelegate <NSObject>

- (void)passBackTransformationsArray:(NSMutableArray *)array;

@end

@interface TransformationListTableViewController : UITableViewController <EnterTransformationTableViewDelegate>

@property (strong, nonatomic) id <TransformationListTableViewDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *transformations;

@property (strong, nonatomic) NSMutableDictionary *transformation;

- (IBAction)addButton:(id)sender;

@end
