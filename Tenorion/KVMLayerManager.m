//
//  KVMLayerManager.m
//  Tenorion
//
//  Created by Kimberly Merrill on 11/7/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMLayerManager.h"

@implementation KVMLayerManager

- (id)initWithColumns:(int)layerSize AndColors:(NSMutableArray *)colors AndTarget:(id)target
{
    self = [super init];
    if (self)
    {
        self.layerSize = layerSize;
        self.colorsStack = colors;
        self.target = target;
        [self setupLayers];
    }
    return self;
}

- (void)setupLayers
{
    self.maxLayers = [self.colorsStack count];
    self.currLayerIndex = -1;
    self.currColumnIndex = 0;
    self.layers = [[NSMutableArray alloc] init];
}

- (KVMLayer *)addLayer
{
    KVMLayer* layer = [[KVMLayer alloc] initWithFrame:CGRectMake(0, 0, 290, 380) AndColumns:self.layerSize AndColor:[self.colorsStack lastObject] AndTarget:self.target];
    [self.colorsStack removeLastObject];
    [self.layers addObject:layer];
    self.currLayerIndex++;
    
    // Set added layer as current layer - if only one layer, will be set to current by default
    if (self.currLayerIndex-1 >= 0)
    {
        [self setCurrentLayerFlagsAt:self.currLayerIndex-1 To:NO];
    }
    
    return layer;
}

- (void)deleteLayerAtIndex:(int)index IsLastLayer:(BOOL)isLastLayer
{
    // In case garbage collection not immediate, turn all switches in layer off
    // and set current layer flags to false
    KVMLayer* layerToDelete = [self.layers objectAtIndex:index];
    [self setLayerOff:layerToDelete];
    [self setCurrentLayerFlagsAt:index To:NO];
    
    // Remove layer from view and from array of layers
    [self.colorsStack addObject:layerToDelete.switchColor];
    [layerToDelete removeFromSuperview];
    [self.layers removeObjectAtIndex:index];
    
    if (isLastLayer)
    {
        self.currLayerIndex = index - 1;
    }
    else
    {
        // If layer in the middle of the array, move all layers to the left
        NSMutableArray* tempLayers = [[NSMutableArray alloc] init];
        for (KVMLayer* layer in self.layers)
        {
            [tempLayers addObject:layer];
        }
    
        self.layers = tempLayers;
        self.currLayerIndex = index;
    }
    
    // Current layer is the layer to the right of the deleted layer, if exists
    // Else current layer is the layer to the left of the deleted layer
    if (self.currLayerIndex >= 0)
    {
        [self setCurrentLayerFlagsAt:self.currLayerIndex To:YES];
    }
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

- (KVMLayer *)getNextLayerToPan:(BOOL)willPan
{
    self.currLayerIndex++;
    if (willPan)
    {
        // Update current layer if about to pan to different layer
        [self setCurrentLayerFlagsAt:self.currLayerIndex-1 To:NO];
        [self setCurrentLayerFlagsAt:self.currLayerIndex To:YES];
    }
    return [self.layers objectAtIndex:self.currLayerIndex];
}

- (KVMLayer *)getPreviousLayerToPan:(BOOL)willPan
{
    self.currLayerIndex--;
    if (willPan)
    {
        // Update current layer if about to pan to different layer
        [self setCurrentLayerFlagsAt:self.currLayerIndex+1 To:NO];
        [self setCurrentLayerFlagsAt:self.currLayerIndex To:YES];
    }
    return [self.layers objectAtIndex:self.currLayerIndex];
}

- (KVMLayer *)getCurrentLayer
{
    return [self.layers objectAtIndex:self.currLayerIndex];
}

- (NSMutableArray *)getNextColumn
{
    NSMutableArray* currColumn = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.layers.count; i++)
    {
        // Accumulate all switches in current column from all layers
        KVMLayer* currLayer = [self.layers objectAtIndex:i];
        [currColumn addObjectsFromArray:[currLayer.switches objectAtIndex:self.currColumnIndex]];
    }
    self.currColumnIndex++;
    return currColumn;
}

- (void)resetColumns
{
    self.currColumnIndex = 0;
}

- (void)setLayerOff:(KVMLayer *)layer
{
    for (NSMutableArray* tempColumn in layer.switches)
    {
        for (KVMSwitch* tempSwitch in tempColumn)
        {
            tempSwitch.isOn = NO;
        }
    }
}

- (void)setCurrentLayerFlagsAt:(int)layerIndex To:(BOOL)isCurrLayer
{
    // Set flag on all switches in layer to indicate if current layer
    // Must be set switch-wise because switches are continuously accessed by column
    // in animation loop (with no reference to containing layer)
    KVMLayer* tempLayer = [self.layers objectAtIndex:layerIndex];
    for (NSMutableArray* tempColumn in tempLayer.switches)
    {
        for (KVMSwitch* tempSwitch in tempColumn)
        {
            tempSwitch.currLayerFlag = isCurrLayer;
        }
    }
}

@end
