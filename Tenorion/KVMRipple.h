//
//  KVMRipple.h
//  Tenorion
//
//  Created by Kimberly Merrill on 12/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVMRipple : UIView

@property int x;
@property int y;
@property int size;

- (id)initWithFrame:(CGRect)frame AtCenterX:(int)x AndY:(int)y WithSize:(int)size;

@end
