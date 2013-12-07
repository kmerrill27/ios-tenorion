//
//  KVMRipple.m
//  Tenorion
//
//  Created by Kimberly Merrill on 12/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMRipple.h"

@implementation KVMRipple

- (id)initWithFrame:(CGRect)frame AtCenterX:(int)x AndY:(int)y WithSize:(int)size
{
    self = [super initWithFrame:frame];
    if (self) {
        self.x = x;
        self.y = y;
        self.size = size;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = .5;
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 8.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rectangle = CGRectMake(self.x-self.size/2, self.y-self.size/2, self.size, self.size);
    CGContextAddEllipseInRect(context, rectangle);
    CGContextStrokePath(context);
}

@end
