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

- (id)initWithNibName:(NSString *)nibNameOrNil WithColor:(UIColor *)color AndTarget:(id)target AndAction:(SEL)dismissAction AndDeleteAction:(SEL)deleteAction
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        self.themeColor = color;
        self.target = target;
        self.dismissAction = dismissAction;
        self.deleteAction = deleteAction;
        self.isBeingDismissed = NO;
    }
    return self;
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
    [self.target performSelector:self.deleteAction withObject:nil afterDelay:0.0];
    self.isBeingDismissed = YES;
    [self.target performSelector:self.dismissAction withObject:nil afterDelay:0.0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.deleteButton setTitleColor:self.themeColor forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
