//
//  KVMLayerManager.h
//  Tenorion
//
//  Created by Kimberly Merrill on 11/7/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVMLayer.h"

@interface KVMLayerManager : UITabBarController

@property int currLayerIndex;
@property int currColumnIndex;
@property int layerSize;
@property int maxLayers;
@property (strong, nonatomic) NSMutableArray* colorsStack;
@property (strong, nonatomic) NSMutableArray* layers;

- (id)initWithColumns:(int)layerSize AndColors:(NSMutableArray *)colors;
- (BOOL)canAddLayer;
- (BOOL)hasNextLayer;
- (BOOL)hasPreviousLayer;
- (BOOL)hasNextColumn;
- (void)resetColumns;
- (void)deleteLayerAtIndex:(int)index IsLastLayer:(BOOL)isLastLayer;
- (KVMLayer *)addLayer;
- (KVMLayer *)getNextLayer;
- (KVMLayer *)getPreviousLayer;
- (KVMLayer *)getCurrentLayer;
- (NSMutableArray *)getNextColumn;

@end
