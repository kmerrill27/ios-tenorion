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
    }
    return self;
}

- (void)startPlayback
{
    [UIView animateWithDuration:0 animations:^{
        [self playSwitchBoard];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0 animations:^{
            [self performSelector:@selector(startPlayback) withObject:nil afterDelay:3.0];
        }];
    }];
}

- (void)playSwitchBoard
{
    int i = 0;
    while ([self.layerManager hasNextColumn])
    {
        [self performSelector:@selector(playSwitchColumn:) withObject:[self.layerManager getNextColumn] afterDelay:0.25*i];
        i++;
    }
    [self.layerManager resetColumns];
}

- (void)playSwitchColumn:(NSMutableArray *)switchColumn
{
    for (KVMSwitch* currSwitch in switchColumn)
    {
        [currSwitch play];
    }
}

@end
