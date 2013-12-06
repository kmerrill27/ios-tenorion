//
//  KVMOptionsViewController.h
//  Tenorion
//
//  Created by Kimberly Merrill on 11/7/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVMToneGroups.h"

@interface KVMOptionsViewController : UIViewController

@property id target;
@property SEL dismissAction;
@property SEL deleteAction;
@property SEL volumeAction;
@property SEL tonesAction;
@property BOOL isBeingDismissed;
@property UIColor* themeColor;

@property int scale;
@property int frequency;
@property int instrument;

@property (strong, nonatomic) KVMToneGroups* toneGroups;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer* panRecognizer;
@property (strong, nonatomic) IBOutlet UISlider* volumeSlider;
@property (strong, nonatomic) IBOutlet UISegmentedControl* scaleControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl* frequencyControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl* instrumentControl;

- (id)initWithNibName:(NSString *)nibNameOrNil WithColor:(UIColor *)color AndTarget:(id)target;
- (void)setDismissAction:(SEL)disAction AndDeleteAction:(SEL)delAction AndVolumeAction:(SEL)volAction AndTonesAction:(SEL)tonesAction;
- (void)finishedDismissal;
- (IBAction)didPan:(UIPanGestureRecognizer *)recognizer;
- (IBAction)didChangeVolume:(UISlider *)sender;
- (IBAction)didChangeInstrument:(UISegmentedControl *)sender;
- (IBAction)didChangeScale:(UISegmentedControl *)sender;
- (IBAction)didChangeFrequency:(UISegmentedControl *)sender;
- (IBAction)didPressDelete:(UIButton *)sender;
- (NSArray *)getTones;

@end
