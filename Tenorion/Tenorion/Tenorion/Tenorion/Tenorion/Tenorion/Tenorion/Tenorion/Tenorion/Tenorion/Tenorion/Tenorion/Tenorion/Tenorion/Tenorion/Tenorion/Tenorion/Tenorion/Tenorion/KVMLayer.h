//
//  KVMSwitchBoard.h
//  Tenorion
//
//  Created by Kimberly Merrill on 11/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVMSwitch.h"

@interface KVMLayer : UIView

@property int size;
@property (strong, nonatomic) UIColor* switchColor;
@property (strong, nonatomic) NSMutableArray* switches;

- (id)initWithFrame:(CGRect)frame AndColumns:(int)size AndColor:(UIColor *)color;
- (NSMutableArray *)getColumn:(int)columnIndex;
- (UIColor *)getColor;

@end
