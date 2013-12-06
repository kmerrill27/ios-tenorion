//
//  KVMOptionsViewController.m
//  Tenorion
//
//  Created by Kimberly Merrill on 11/7/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMOptionsViewController.h"

@interface KVMOptionsViewController ()

@end

@implementation KVMOptionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil WithColor:(UIColor *)color AndTarget:(id)target
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        self.themeColor = color;
        self.target = target;
        self.toneGroups = [[KVMToneGroups alloc] init];
        self.isBeingDismissed = NO;
        self.scale = self.scaleControl.selectedSegmentIndex;
        self.frequency = self.frequencyControl.selectedSegmentIndex;
        self.instrument = self.instrumentControl.selectedSegmentIndex;
    }
    return self;
}

- (void)setDismissAction:(SEL)disAction AndDeleteAction:(SEL)delAction AndVolumeAction:(SEL)volAction AndTonesAction:(SEL)tonesAction
{
    self.dismissAction = disAction;
    self.deleteAction = delAction;
    self.volumeAction = volAction;
    self.tonesAction = tonesAction;
}

- (void)finishedDismissal
{
    self.isBeingDismissed = NO;
}

- (IBAction)didPan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint velocity = [recognizer velocityInView:self.view];
    
    // Down gesture
    if (velocity.y > 0 && !self.isBeingDismissed)
    {
        self.isBeingDismissed = YES;
        [self.target performSelector:self.dismissAction withObject:nil afterDelay:0.0];
    }
}

- (IBAction)didPressDelete:(UIButton *)sender
{
    [self.target performSelector:self.dismissAction withObject:nil afterDelay:0.0];
    [self.target performSelector:self.deleteAction withObject:nil afterDelay:0.0];
}

- (IBAction)didChangeVolume:(UISlider *)sender
{
    [self.target performSelector:self.volumeAction withObject:[NSNumber numberWithFloat:[sender value]] afterDelay:0.0];
}

- (IBAction)didChangeInstrument:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 1)
    {
        [self fadeElement:self.scaleControl InDirection:YES];
        [self fadeElement:self.frequencyControl InDirection:YES];
    }
    else if (self.scaleControl.hidden == YES)
    {
        [self fadeElement:self.scaleControl InDirection:NO];
        [self fadeElement:self.frequencyControl InDirection:NO];
    }
    
    self.instrument = sender.selectedSegmentIndex;
    [self.target performSelector:self.tonesAction withObject:[self getTones] afterDelay:0.0];
}

- (IBAction)didChangeScale:(UISegmentedControl *)sender
{
    self.scale = sender.selectedSegmentIndex;
    [self.target performSelector:self.tonesAction withObject:[self getTones] afterDelay:0.0];
}

- (IBAction)didChangeFrequency:(UISegmentedControl *)sender
{
    self.frequency = sender.selectedSegmentIndex;
    [self.target performSelector:self.tonesAction withObject:[self getTones] afterDelay:0.0];
}

- (void)fadeElement:(UISegmentedControl *)control InDirection:(BOOL)inOrOut
{
    [UIView transitionWithView:control
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    control.hidden = inOrOut;
}

- (NSArray *)getTones
{
    return [self.toneGroups getTonesWithInstrument:self.instrument AndScale:self.scale AndFrequency:self.frequency];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.volumeSlider.minimumTrackTintColor = self.themeColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
