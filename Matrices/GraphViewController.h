//
//  GraphViewController.h
//  Test
//
//  Created by Jono Muller on 02/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"
#import "Matrix.h"

@interface GraphViewController : UIViewController <UIScrollViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) IBOutlet GraphView *graphView;

@property (strong, nonatomic) Matrix *matrix;

@end
