//
//  KVMRipple.m
//  Tenorion
//
//  Created by Kimberly Merrill on 12/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMRipple.h"

@implementation KVMRipple

- (id)initWithFrame:(CGRect)frame AtCenterX:(int)x AndY:(int)y WithSize:(int)size AndColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.x = x;
        self.y = y;
        self.size = size;
        self.color = [self changeAlphaOf:color To:0.4];
        self.backgroundColor = [UIColor clearColor];
        self.alpha = .1;
        self.userInteractionEnabled = NO;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5.0);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGRect rectangle = CGRectMake(self.x-self.size/2, self.y-self.size/2, self.size, self.size);
    CGContextAddEllipseInRect(context, rectangle);
    CGContextStrokePath(context);
}

- (UIColor *)changeAlphaOf:(UIColor *)color To:(CGFloat)newAlpha
{
    if (color == [UIColor whiteColor])
    {
        return [UIColor colorWithWhite:1.0 alpha:newAlpha];
    }
    
    CGFloat red, green, blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    UIColor* newColor = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:newAlpha];
    return newColor;
}

@end
