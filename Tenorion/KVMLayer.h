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

@interface KVMLayer : UIView

@property id target;
@property int size;
@property (strong, nonatomic) UIColor* switchColor;
@property (strong, nonatomic) NSMutableArray* switches;
@property (strong, nonatomic) KVMOptionsViewController* optionsController;

- (id)initWithFrame:(CGRect)frame AndColumns:(int)size AndColor:(UIColor *)color AndTarget:(id)target;
- (NSMutableArray *)getColumn:(int)columnIndex;
- (UIColor *)getColor;
- (KVMOptionsViewController *)getOptionsController;
- (void)setupOptionsControllerWithDismissAction:(SEL)dismissAction AndDeleteAction:(SEL)deleteAction;
- (void)setVolume:(float)volume;

@end
