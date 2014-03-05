//
//  GraphViewController.m
//  Test
//
//  Created by Jono Muller on 02/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

@synthesize scroller, graphView, matrix;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UIAlertView *noMatrices = [[UIAlertView alloc] initWithTitle:@"No matrices found" message:@"Please add enter at least one matrix or transformation first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];
    
    UIAlertView *wrongSize = [[UIAlertView alloc] initWithTitle:@"Wrong size for matrix" message:@"Please enter a matrix of size 2x2" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];
    
    if (!matrix.name) {
        [noMatrices show];
    } else if (matrix.row != 2 || matrix.column != 2) {
        [wrongSize show];
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    scroller.contentSize = CGSizeMake(kDefaultGraphWidth, kGraphHeight);
    scroller.maximumZoomScale = 4.0;
    scroller.minimumZoomScale = 0.6;
    scroller.clipsToBounds = YES;
    
//    scroller.contentScaleFactor = 4;

    scroller.contentOffset = CGPointMake(340, 252);
    scroller.zoomScale = 0.01;
    
    self.graphView.matrix = matrix;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return graphView;
}

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
