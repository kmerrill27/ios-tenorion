//
//  KVMSwitchBoard.m
//  Tenorion
//
//  Created by Kimberly Merrill on 11/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMLayer.h"

@implementation KVMLayer

- (id)initWithFrame:(CGRect)frame AndColumns:(int)size AndColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.size = size;
        self.switchColor = color;
        self.opaque = NO;
        [self drawSwitches];
    }
    return self;
}

- (NSMutableArray *)getColumn:(int)columnIndex
{
    return [self.switches objectAtIndex:columnIndex];
}

- (UIColor *)getColor
{
    return self.switchColor;
}

- (void)didPressSwitch:(KVMSwitch*)pressedSwitch
{
    [pressedSwitch toggle];
}

- (void)drawSwitches
{
    int switchSize = 30;
    self.switches = [[NSMutableArray alloc] init];

    for(int row = 0; row < self.size; row++) {
        NSMutableArray* switchColumn = [[NSMutableArray alloc] init];
        [self.switches addObject:switchColumn];
        
        for(int col = 0; col < self.size; col++) {
            KVMSwitch* tempSwitch = [[KVMSwitch alloc] initWithFrame:CGRectMake(row * (switchSize+3), col * (switchSize+3), switchSize, switchSize) WithTone:@"3C.wav" AndColor:self.switchColor];
            [tempSwitch addTarget:self action:@selector(didPressSwitch:) forControlEvents:UIControlEventTouchUpInside];
            [switchColumn addObject:tempSwitch];
            [self addSubview:tempSwitch];
        }
    }
}

@end
