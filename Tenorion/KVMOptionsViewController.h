//
//  KVMOptionsViewController.h
//  Tenorion
//
//  Created by Kimberly Merrill on 11/7/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVMOptionsViewController : UIViewController

@property id target;
@property SEL dismissAction;
@property SEL deleteAction;
@property UIColor* themeColor;
@property BOOL isBeingDismissed;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer* panRecognizer;
@property (strong, nonatomic) IBOutlet UIButton* deleteButton;

- (id)initWithNibName:(NSString *)nibNameOrNil WithColor:(UIColor *)color AndTarget:(id)target AndAction:(SEL)dismissAction AndDeleteAction:(SEL)deleteAction;
- (IBAction)didPan:(UIPanGestureRecognizer *)recognizer;
- (IBAction)didPressDelete:(UIButton *)sender;

@end
