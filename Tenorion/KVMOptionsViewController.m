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
        self.isBeingDismissed = NO;
    }
    return self;
}

- (void)setDismissAction:(SEL)dismissAction AndDeleteAction:(SEL)deleteAction
{
    self.dismissAction = dismissAction;
    self.deleteAction = deleteAction;
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
}

- (IBAction)didChangeScale:(UISegmentedControl *)sender
{
    
}

- (IBAction)didChangeFrequency:(UISegmentedControl *)sender
{
    
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
