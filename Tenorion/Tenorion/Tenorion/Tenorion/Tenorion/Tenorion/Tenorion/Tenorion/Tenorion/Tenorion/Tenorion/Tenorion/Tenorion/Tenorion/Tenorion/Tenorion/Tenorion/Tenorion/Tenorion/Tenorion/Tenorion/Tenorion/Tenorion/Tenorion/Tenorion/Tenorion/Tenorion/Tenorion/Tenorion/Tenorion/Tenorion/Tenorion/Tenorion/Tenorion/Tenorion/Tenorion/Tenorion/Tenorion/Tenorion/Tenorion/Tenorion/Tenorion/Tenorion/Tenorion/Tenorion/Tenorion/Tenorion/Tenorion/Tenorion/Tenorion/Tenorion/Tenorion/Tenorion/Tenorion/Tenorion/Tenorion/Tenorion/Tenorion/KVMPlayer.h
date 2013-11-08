//
//  KVMPlayer.h
//  Tenorion
//
//  Created by Kimberly Merrill on 11/7/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVMSwitch.h"
#import "KVMLayerManager.h"

@interface KVMPlayer : NSObject

@property (strong, nonatomic) KVMLayerManager* layerManager;

- (id)initWithLayerManager:(KVMLayerManager *)layerManager;
- (void)startPlayback;

@end
