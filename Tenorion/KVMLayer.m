//
//  KVMSwitchBoard.m
//  Tenorion
//
//  Created by Kimberly Merrill on 11/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMLayer.h"

@implementation KVMLayer

- (id)initWithFrame:(CGRect)frame AndColumns:(int)size AndColor:(UIColor *)color AndTarget:(id)target
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.size = size;
        self.switchColor = color;
        self.target = target;
        self.opaque = NO;
        self.optionsController = [[KVMOptionsViewController alloc] initWithNibName:@"KVMOptionsViewController" WithColor:self.switchColor AndTarget:self];
        [self drawSwitches];
    }
    return self;
}

- (void)setupOptionsControllerWithDismissAction:(SEL)dismissAction AndDeleteAction:(SEL)deleteAction
{
    self.dismissAction = dismissAction;
    self.deleteAction = deleteAction;
    
    [self.optionsController setDismissAction:@selector(dismissOptionsController) AndDeleteAction:@selector(deleteLayer) AndVolumeAction:@selector(setVolume:) AndTonesAction:@selector(setTones:)];
}

- (KVMOptionsViewController *)getOptionsController
{
    return self.optionsController;
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
    
    NSArray* startingTones = [self.optionsController getTones];

    for(int row = 0; row < self.size; row++)
    {
        NSMutableArray* switchColumn = [[NSMutableArray alloc] init];
        [self.switches addObject:switchColumn];
        
        for(int col = 0; col < self.size; col++)
        {
            KVMSwitch* tempSwitch = [[KVMSwitch alloc] initWithFrame:CGRectMake(row * (switchSize+3), col * (switchSize+3), switchSize, switchSize) WithTone:[startingTones objectAtIndex:col] AndColor:self.switchColor];
            [tempSwitch addTarget:self action:@selector(didPressSwitch:) forControlEvents:UIControlEventTouchUpInside];
            [switchColumn addObject:tempSwitch];
            [self addSubview:tempSwitch];
        }
    }
}

- (void)setVolume:(NSNumber *)volume
{
    for (NSMutableArray* switchColumn in self.switches)
    {
        for (KVMSwitch* currSwitch in switchColumn)
        {
            [currSwitch setVolume:volume.floatValue];
        }
    }
}

- (void)setTones:(NSArray *)tones
{
    for (int row = 0; row < self.size; row++)
    {
        NSMutableArray* currColumn = [self.switches objectAtIndex:row];
        for (int col = 0; col < self.size; col++)
        {
            KVMSwitch* currSwitch = [currColumn objectAtIndex:col];
            [currSwitch setToneFile:[tones objectAtIndex:col]];
        }
    }
}

- (void)dismissOptionsController
{
    [self.target performSelector:self.dismissAction withObject:nil afterDelay:0.0];
}

- (void)deleteLayer
{
    [self.target performSelector:self.deleteAction withObject:nil afterDelay:0.0];
}

@end
