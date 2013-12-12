//
//  KVMCircleButton.h
//  Tenorion
//
//  Created by Kimberly Merrill on 11/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundManager.h"
#import "KVMRipple.h"

@interface KVMSwitch : UIButton

@property BOOL isOn;
@property BOOL currLayerFlag;
@property float volume;
@property KVMRipple* ripple;
@property (strong, nonatomic) NSString* toneFile;
@property (strong, nonatomic) UIColor* onColor;
@property (strong, nonatomic) UIColor* offColor;

- (id)initWithFrame:(CGRect)frame WithTone:(NSString *)toneFile AndColor:(UIColor *)color;
- (void)toggle;
- (void)playOn:(UIView *)view;
- (void)highlight;

@end
