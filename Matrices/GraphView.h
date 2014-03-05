//
//  GraphView.h
//  Test
//
//  Created by Jono Muller on 02/02/2014.
//  Copyright (c) 2014 Jono Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Matrix.h"

#define kGraphHeight 1000
#define kDefaultGraphWidth 1000
#define kOffsetX 10
#define kStepX 30
#define kOffsetY 10
#define kStepY 30
#define kGraphBottom 1000
#define kGraphTop 0

@interface GraphView : UIView

@property (strong, nonatomic) Matrix *matrix;

@property (nonatomic) CGFloat zeroX, zeroY;
@property (nonatomic) int howMany, howManyHorizontal;

- (void)drawSquare:(CGContextRef)context;
- (void)drawTransformedSquare:(CGContextRef)context;

@end
