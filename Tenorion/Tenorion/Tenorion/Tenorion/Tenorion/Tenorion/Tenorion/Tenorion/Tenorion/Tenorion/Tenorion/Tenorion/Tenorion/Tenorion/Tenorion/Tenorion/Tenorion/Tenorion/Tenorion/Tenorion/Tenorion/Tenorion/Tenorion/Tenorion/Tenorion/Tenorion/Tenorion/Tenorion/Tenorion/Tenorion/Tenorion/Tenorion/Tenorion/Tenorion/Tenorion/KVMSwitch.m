//
//  KVMCircleButton.m
//  Tenorion
//
//  Created by Kimberly Merrill on 11/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMSwitch.h"

@implementation KVMSwitch

- (id)initWithFrame:(CGRect)frame WithTone:(NSString *)toneFile AndColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.switchTone = [[KVMTone alloc] initWithTone:toneFile];
        self.onColor = color;
        [self setupSwitch];
    }
    return self;
}

- (void)setupSwitch
{
    self.offColor = [self.onColor colorWithAlphaComponent:0.3];
    self.isOn = NO;
    self.backgroundColor = self.offColor;
    self.layer.cornerRadius = self.bounds.size.width / 2.0;
}

- (void)toggle
{
    self.isOn = !self.isOn;
    if (self.isOn)
    {
        self.backgroundColor = self.onColor;
    }
    else {
        self.backgroundColor = self.offColor;
    }
}

- (void)play
{
    if (self.isOn)
    {
        int originalSize = self.bounds.size.width;
        [UIView animateWithDuration:0.2 animations:^{
            [self setBounds:CGRectMake(0, 0, originalSize+1.5, originalSize+1.5)];
            [self.switchTone playTone];
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.2 animations:^{
                [self setBounds:CGRectMake(0, 0, originalSize, originalSize)];
            }];
        }];
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
    {
        //self.backgroundColor = [UIColor lightGrayColor];
    }
    else
    {
        //self.backgroundColor = [UIColor blueColor];
    }
}

@end
