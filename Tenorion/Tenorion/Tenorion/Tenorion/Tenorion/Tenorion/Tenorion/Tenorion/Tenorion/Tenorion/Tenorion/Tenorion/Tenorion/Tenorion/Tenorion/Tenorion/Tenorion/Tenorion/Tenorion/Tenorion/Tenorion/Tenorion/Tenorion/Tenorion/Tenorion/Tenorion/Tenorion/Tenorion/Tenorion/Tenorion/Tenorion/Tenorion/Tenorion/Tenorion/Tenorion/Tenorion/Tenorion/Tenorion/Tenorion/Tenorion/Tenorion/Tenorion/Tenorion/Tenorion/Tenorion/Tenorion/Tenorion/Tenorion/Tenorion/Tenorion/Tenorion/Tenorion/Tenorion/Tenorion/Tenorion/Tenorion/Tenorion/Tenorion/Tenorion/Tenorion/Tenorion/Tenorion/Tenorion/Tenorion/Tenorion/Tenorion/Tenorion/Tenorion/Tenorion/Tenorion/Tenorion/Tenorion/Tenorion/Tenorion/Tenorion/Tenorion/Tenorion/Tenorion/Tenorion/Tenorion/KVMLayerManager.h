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
@property (strong, nonatomic) NSMutableArray* colors;
@property (strong, nonatomic) NSMutableArray* layers;
@property (strong, nonatomic) UISegmentedControl* layerControl;

- (id)initWithColumns:(int)layerSize AndColors:(NSMutableArray *)colors;
- (BOOL)canAddLayer;
- (KVMLayer *)addLayer;
- (BOOL)hasNextLayer;
- (BOOL)hasPreviousLayer;
- (BOOL)hasNextColumn;
- (KVMLayer *)getNextLayer;
- (KVMLayer *)getPreviousLayer;
- (NSMutableArray *)getNextColumn;
- (void)resetColumns;

@end
