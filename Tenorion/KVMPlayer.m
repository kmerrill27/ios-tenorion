//
//  KVMPlayer.m
//  Tenorion
//
//  Created by Kimberly Merrill on 11/7/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMPlayer.h"

@implementation KVMPlayer

- (id)initWithLayerManager:(KVMLayerManager *)layerManager
{
    self = [super init];
    if (self)
    {
        self.layerManager = layerManager;
        self.soundManager = [SoundManager sharedManager];
        [self.soundManager prepareToPlay];
    }
    return self;
}

- (void)startPlayback
{
    [UIView animateWithDuration:0 animations:^{
        [self playSwitchBoard];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0 animations:^{
            [self performSelector:@selector(startPlayback) withObject:nil afterDelay:2.38];
        }];
    }];
}

- (void)playSwitchBoard
{
    int i = 0;
    while ([self.layerManager hasNextColumn])
    {
        [self performSelector:@selector(playSwitchColumn:) withObject:[self.layerManager getNextColumn] afterDelay:0.3*i];
        i++;
    }
    [self.layerManager resetColumns];
}

- (void)playSwitchColumn:(NSMutableArray *)switchColumn
{
    for (KVMSwitch* currSwitch in switchColumn)
    {
        if (currSwitch.isOn)
        {
            [currSwitch play];
            [self.soundManager playSound:currSwitch.toneFile WithVolume:currSwitch.volume];
        }
        else
        {
            [currSwitch highlight];
        }
    }
}

@end
