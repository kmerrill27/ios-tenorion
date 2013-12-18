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
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self playSwitchBoard];
    }  completion:^(BOOL finished){
        [self performSelector:@selector(startPlayback) withObject:nil afterDelay:3];
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
        UIViewController* targetController = self.layerManager.target;
        [currSwitch playOn:targetController.view WithSoundManager:self.soundManager];
    }
}

@end
