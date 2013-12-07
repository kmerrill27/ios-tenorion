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
        self.toneFile = toneFile;
        self.onColor = color;
        self.volume = 1.0f;
        [self setupSwitch];
    }
    return self;
}

- (void)setupSwitch
{
    self.offColor = [self.onColor colorWithAlphaComponent:0.3];
    self.isOn = NO;
    self.currLayerFlag = YES;
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

- (void)playOn:(UIView *)view
{
    int originalSize = self.bounds.size.width;
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self setBounds:CGRectMake(0, 0, originalSize+1.5, originalSize+1.5)];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [self setBounds:CGRectMake(0, 0, originalSize, originalSize)];
        } completion:nil];
    }];
    
    CGPoint center = [self.superview convertPoint:self.center toView:view];
    KVMRipple* ripple = [[KVMRipple alloc] initWithFrame:view.frame AtCenterX:center.x AndY:center.y WithSize:self.bounds.size.width];
    [view addSubview:ripple];
}

- (void)highlight
{
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.backgroundColor = [self.offColor colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            if (self.isOn)
            {
                self.backgroundColor = self.onColor;
            }
            else
            {
                self.backgroundColor = self.offColor;
            }
        } completion:nil];
    }];
}

@end
