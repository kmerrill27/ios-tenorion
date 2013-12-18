//
//  KVMSwitchBoard.h
//  Tenorion
//
//  Created by Kimberly Merrill on 11/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVMSwitch.h"
#import "KVMOptionsViewController.h"
#import "KVMToneGroups.h"

@interface KVMLayer : UIView

@property id target;
@property int size;
@property SEL dismissAction;
@property SEL deleteAction;
@property (strong, nonatomic) KVMToneGroups* toneGroups;
@property (strong, nonatomic) UIColor* switchColor;
@property (strong, nonatomic) NSMutableArray* switches;
@property (strong, nonatomic) KVMOptionsViewController* optionsController;

- (id)initWithFrame:(CGRect)frame AndColumns:(int)size AndColor:(UIColor *)color AndTarget:(id)target;
- (void)setupOptionsControllerWithDismissAction:(SEL)dismissAction AndDeleteAction:(SEL)deleteAction;
- (void)setVolume:(NSNumber *)volume;
- (void)setTones:(NSArray *)tones;

@end
