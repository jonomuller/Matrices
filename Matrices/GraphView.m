//
//  GraphView.m
//  Test
//
//  Created by Jono Muller on 02/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView

@synthesize matrix, zeroX, zeroY, howMany, howManyHorizontal;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Draws path for unit square
- (void)drawSquare:(CGContextRef)context
{
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetGrayFillColor(context, 0.0, 0.3);
    
    CGPoint points[] = {CGPointMake(zeroX, zeroY), CGPointMake(zeroX + 2 * kStepX, zeroY), CGPointMake(zeroX + 2 * kStepX, zeroY - 2 * kStepY), CGPointMake(zeroX, zeroY - 2 * kStepY), CGPointMake(zeroX, zeroY)};
    
    for (int i = 0; i < sizeof(points)/sizeof(CGPoint); i++) {
        if (i == 0) {
            CGContextMoveToPoint(context, points[i].x, points[i].y);
        } else {
            CGContextAddLineToPoint(context, points[i].x, points[i].y);
        }
    }
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

// Draws path for transformed unit square
- (void)drawTransformedSquare:(CGContextRef)context
{
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3] CGColor]);
    
    CGPoint points[] = {CGPointMake(zeroX, zeroY), CGPointMake(zeroX + 2 * kStepX * [[[matrix.elements objectAtIndex:0] objectAtIndex:0] floatValue], zeroY - 2 * kStepY * [[[matrix.elements objectAtIndex:1] objectAtIndex:0] floatValue]), CGPointMake(zeroX + 2 * kStepX * ([[[matrix.elements objectAtIndex:0] objectAtIndex:0] floatValue] + [[[matrix.elements objectAtIndex:0] objectAtIndex:1] floatValue]), zeroY - 2 * kStepY * ([[[matrix.elements objectAtIndex:1] objectAtIndex:0] floatValue] + [[[matrix.elements objectAtIndex:1] objectAtIndex:1] floatValue])), CGPointMake(zeroX + 2 * kStepX * [[[matrix.elements objectAtIndex:0] objectAtIndex:1] floatValue], zeroY - 2 * kStepY * [[[matrix.elements objectAtIndex:1] objectAtIndex:1] floatValue]), CGPointMake(zeroX, zeroY)};
    
    for (int i = 0; i < sizeof(points)/sizeof(CGPoint); i++) {
        if (i == 0) {
            CGContextMoveToPoint(context, points[i].x, points[i].y);
        } else {
            CGContextAddLineToPoint(context, points[i].x, points[i].y);
        }
    }
    
    CGContextDrawPath(context, kCGPathFillStroke);
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    UIAlertView *noMatrices = [[UIAlertView alloc] initWithTitle:@"No matrices found" message:@"Please add enter at least one matrix or transformation first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];
//    
//    UIAlertView *wrongSize = [[UIAlertView alloc] initWithTitle:@"Wrong size for matrix" message:@"Please enter a matrix of maximum size 2x2" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];
//    
//    if (!matrix.name) {
//        [noMatrices show];
//    }
//    
//    if (matrix.column != 2 || matrix.row != 2) {
////        [wrongSize show];
//    }
    
//    matrix = [[Matrix alloc] init];
//    matrix.elements = [[NSMutableArray alloc] initWithObjects:[NSMutableArray arrayWithObjects:@2, @0, nil], [NSMutableArray arrayWithObjects:@0, @2, nil], nil];
    
    howMany = (kDefaultGraphWidth - kOffsetX) / kStepX;
    howManyHorizontal = (kGraphBottom - kGraphTop - kOffsetY) / kStepY;
    
    zeroX = (howManyHorizontal / 2) * kStepX;
    zeroY = kGraphBottom - (howMany / 2) * kStepY;
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Draw grid lines
    CGContextSetLineWidth(context, 0.4);
    CGContextSetStrokeColorWithColor(context, [[UIColor grayColor] CGColor]);

    for (int i = 0; i <= howMany; i++) {
        CGContextMoveToPoint(context, i * kStepX, kGraphTop);
        CGContextAddLineToPoint(context, i * kStepX, kGraphBottom);
    }

    for (int i = 0; i <= howManyHorizontal; i++) {
        CGContextMoveToPoint(context, 0, kGraphBottom - i * kStepY);
        CGContextAddLineToPoint(context, kDefaultGraphWidth, kGraphBottom - i * kStepY);
    }
    
    CGContextStrokePath(context);
    
    // Draw axes
    CGContextSetLineWidth(context, 0.8);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    
    CGContextMoveToPoint(context, 0, kGraphBottom - (howManyHorizontal / 2) * kStepY);
    CGContextAddLineToPoint(context, kDefaultGraphWidth, kGraphBottom - (howManyHorizontal / 2) * kStepY);
    
    CGContextMoveToPoint(context, (howMany / 2) * kStepX, 0);
    CGContextAddLineToPoint(context, (howMany / 2) * kStepX, kGraphBottom);
    
    CGContextStrokePath(context);
    
    // Draw data points along axes
    for (int i = - howMany / 2 + 4; i <= howMany / 2; i++) {
        NSString *text = [NSString stringWithFormat:@"%d", i];
        [text drawAtPoint:CGPointMake((i*2+howMany/2) * kStepY - 7, kGraphBottom - (howMany / 2) * kStepY) withAttributes:NULL];
        if (i != 0) {
            [text drawAtPoint:CGPointMake((howMany / 2) * kStepX - 12, kGraphBottom - (i*2+howManyHorizontal/2) * kStepX - 7) withAttributes:NULL];
        }
    }
    
    // Draw unit square
//    CGRect square = CGRectMake((howManyHorizontal / 2) * kStepX, kGraphBottom - (howMany / 2) * kStepY - 2 * kStepY, 2 * kStepX, 2 * kStepY);
    [self drawSquare:context];
    
    // Draw transformed unit square
    if (matrix.row == 2 && matrix.column == 2) {
        [self drawTransformedSquare:context];
    }
}


@end
