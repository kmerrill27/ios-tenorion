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
@property SEL volumeAction;
@property BOOL isBeingDismissed;
@property UIColor* themeColor;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer* panRecognizer;
@property (strong, nonatomic) IBOutlet UISlider* volumeSlider;
@property (strong, nonatomic) IBOutlet UISegmentedControl* scaleControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl* frequencyControl;

- (id)initWithNibName:(NSString *)nibNameOrNil WithColor:(UIColor *)color AndTarget:(id)target;
- (void)setDismissAction:(SEL)dismissAction AndDeleteAction:(SEL)deleteAction AndVolumeAction:(SEL)volumeAction;
- (void)finishedDismissal;
- (IBAction)didPan:(UIPanGestureRecognizer *)recognizer;
- (IBAction)didChangeVolume:(UISlider *)sender;
- (IBAction)didChangeInstrument:(UISegmentedControl *)sender;
- (IBAction)didChangeScale:(UISegmentedControl *)sender;
- (IBAction)didChangeFrequency:(UISegmentedControl *)sender;
- (IBAction)didPressDelete:(UIButton *)sender;

@end
