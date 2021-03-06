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
        self.volume = 0.5f;
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
    else
    {
        self.backgroundColor = self.offColor;
    }
}

- (void)playOn:(UIView *)view WithSoundManager:(SoundManager *)soundManager
{
    if (self.isOn)
    {
        int originalSize = self.bounds.size.width;
        
        // If switch is part of background layer, grow less and don't ripple
        [self setBounds:CGRectMake(0, 0, originalSize+0.75, originalSize+0.75)];
        [soundManager playSound:self.toneFile WithVolume:self.volume];
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [self setBounds:CGRectMake(0, 0, originalSize, originalSize)];
        } completion:nil];
    }
}

- (void)playCurrLayerOn:(UIView *)view WithSoundManager:(SoundManager *)soundManager
{
    if (self.isOn)
    {
        int originalSize = self.bounds.size.width;
        CGPoint center = [self.superview convertPoint:self.center toView:view];
        
        // If switch is on current layer, grow and ripple
        [self setBounds:CGRectMake(0, 0, originalSize+1.5, originalSize+1.5)];
        [self rippleOnView:view WithCenter:center AndSize:originalSize];
        [soundManager playSound:self.toneFile WithVolume:self.volume];
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [self setBounds:CGRectMake(0, 0, originalSize, originalSize)];
        } completion:nil];
    }
    else
    {
        // If switch is off, temporarliy lighten its color to indicate current column
        [self highlight];
    }
}

- (void)highlight
{
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.backgroundColor = [self.offColor colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            // Re-check if on or off in case user toggled switch while it was animating
            self.backgroundColor = self.isOn ? self.onColor : self.offColor;
        } completion:nil];
    }];
}

-(void)rippleOnView:(UIView *)view WithCenter:(CGPoint)center AndSize:(int)size
{
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.ripple = [[KVMRipple alloc] initWithFrame:view.frame AtCenterX:center.x AndY:center.y WithSize:size+5 AndColor:self.onColor];
        [view addSubview:self.ripple];
    } completion:^(BOOL finished){
        [self.ripple removeFromSuperview];
        
        // Flash second slightly larger ripple
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.ripple = [[KVMRipple alloc] initWithFrame:view.frame AtCenterX:center.x AndY:center.y WithSize:size+10 AndColor:self.onColor];
            [view addSubview:self.ripple];
        } completion:^(BOOL finished){
            [self.ripple removeFromSuperview];
        }];
    }];
}

@end
