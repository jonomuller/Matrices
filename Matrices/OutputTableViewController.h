//
//  OutputTableViewController.h
//  Test
//
//  Created by Jono Muller on 27/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Matrix.h"

//@protocol OutputTableViewDelegate <NSObject>
//
//- (void)passBackMatrix:(Matrix *)output;
//
//@end

@interface OutputTableViewController : UITableViewController <UIAlertViewDelegate>

//@property (weak, nonatomic) id <OutputTableViewDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *headers, *matrices, *transformations;

@property (nonatomic) NSInteger selectedType, selectedInput;

@property (strong, nonatomic) Matrix *matrix, *outputMatrix;

@property (strong, nonatomic) NSMutableDictionary *transformation, *outputTransformation;

@end
