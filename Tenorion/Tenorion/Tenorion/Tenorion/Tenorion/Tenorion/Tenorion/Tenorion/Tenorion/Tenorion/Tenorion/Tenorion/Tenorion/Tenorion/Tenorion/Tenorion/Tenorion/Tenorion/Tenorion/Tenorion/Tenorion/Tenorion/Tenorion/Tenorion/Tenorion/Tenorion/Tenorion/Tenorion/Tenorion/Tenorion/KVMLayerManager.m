//
//  KVMLayerManager.m
//  Tenorion
//
//  Created by Kimberly Merrill on 11/7/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMLayerManager.h"

@implementation KVMLayerManager

- (id)initWithColumns:(int)layerSize AndColors:(NSMutableArray *)colors
{
    self = [super init];
    if (self)
    {
        self.layerSize = layerSize;
        self.colors = colors;
        [self setupLayers];
    }
    return self;
}

- (void)setupLayers
{
    self.maxLayers = 2;
    self.currLayerIndex = -1;
    self.currColumnIndex = 0;
    self.layers = [[NSMutableArray alloc] init];
}

- (KVMLayer *)addLayer
{
    int colorIndex = self.currLayerIndex % [self.colors count];
    KVMLayer* layer = [[KVMLayer alloc] initWithFrame:CGRectMake(0, 0, 290, 380) AndColumns:self.layerSize AndColor:[self.colors objectAtIndex:colorIndex]];
    [self.layers addObject:layer];
    self.currLayerIndex++;
    
    return layer;
}

- (BOOL)canAddLayer
{
    return [self.layers count] < self.maxLayers;
}

- (BOOL)hasNextLayer
{
    return self.currLayerIndex < [self.layers count] - 1;
}

- (BOOL)hasPreviousLayer
{
    return self.currLayerIndex > 0;
}

- (BOOL)hasNextColumn
{
    return self.currColumnIndex < self.layerSize;
}

- (KVMLayer *)getNextLayer
{
    self.currLayerIndex++;
    self.layerControl.selectedSegmentIndex = self.currLayerIndex;
    self.layerControl.tintColor = [self.colors objectAtIndex:self.currLayerIndex];
    return [self.layers objectAtIndex:self.currLayerIndex];
}

- (KVMLayer *)getPreviousLayer
{
    self.currLayerIndex--;
    self.layerControl.selectedSegmentIndex = self.currLayerIndex;
    self.layerControl.tintColor = [self.colors objectAtIndex:self.currLayerIndex];
    return [self.layers objectAtIndex:self.currLayerIndex];
}

- (NSMutableArray *)getNextColumn
{
    NSMutableArray* currColumn = [[NSMutableArray alloc] init];
    for (KVMLayer* layer in self.layers)
    {
        NSMutableArray* layerColumn = [layer getColumn:self.currColumnIndex];
        [currColumn addObjectsFromArray:layerColumn];
    }
    self.currColumnIndex++;
    return currColumn;
}

- (void)resetColumns
{
    self.currColumnIndex = 0;
}

@end
