//
//  KVMCircleButton.h
//  Tenorion
//
//  Created by Kimberly Merrill on 11/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVMTone.h"

@interface KVMSwitch : UIButton

@property BOOL isOn;
@property (strong, nonatomic) KVMTone* switchTone;
@property (strong, nonatomic) UIColor* onColor;
@property (strong, nonatomic) UIColor* offColor;

- (id)initWithFrame:(CGRect)frame WithTone:(NSString *)toneFile AndColor:(UIColor *)color;
- (void)toggle;
- (void)play;

@end
