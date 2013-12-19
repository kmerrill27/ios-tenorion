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
    // Continuous animation loop for playing Tenori-on
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self playSwitchBoard];
    }  completion:^(BOOL finished){
        [self performSelector:@selector(startPlayback) withObject:nil afterDelay:3];
    }];
}

- (void)playSwitchBoard
{
    for (int i = 0; i < self.layerManager.layerSize; i++)
    {
        NSNumber* nsi = [NSNumber numberWithInteger:i];
        [self performSelector:@selector(playSwitchColumn:) withObject:nsi afterDelay:0.3*i];
    }
}

- (void)playSwitchColumn:(NSNumber *)index
{
    NSMutableArray* currLayerSwitchColumn = [self.layerManager getColumnOfCurrentLayer:[index intValue]];
    NSMutableArray* switchColumn = [self.layerManager getColumn:[index intValue]];
    UIViewController* targetController = self.layerManager.target;
    
    // Play all switches on current layer in current column
    for (KVMSwitch* currSwitch in currLayerSwitchColumn)
    {
        [currSwitch playCurrLayerOn:targetController.view WithSoundManager:self.soundManager];
    }
    
    // Play all switches on all other layers in current column
    for (KVMSwitch* currSwitch in switchColumn)
    {
        [currSwitch playOn:targetController.view WithSoundManager:self.soundManager];
    }
}

@end
