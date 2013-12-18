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

/**
 * Method must be called from delegate at setup time
 **/
- (void)setupOptionsControllerWithDismissAction:(SEL)dismissAction AndDeleteAction:(SEL)deleteAction
{
    // Set actions to be performed when layer is deleted or optionsController is dismissed
    self.dismissAction = dismissAction;
    self.deleteAction = deleteAction;
    
    [self.optionsController setDismissAction:@selector(dismissOptionsController) AndDeleteAction:@selector(deleteLayer) AndVolumeAction:@selector(setVolume:) AndTonesAction:@selector(setTones:)];
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

    // Draw size by size grid of switches
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
    // Adjust volume for all switches in layer
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
    // Set corresponding tone for each switch
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
