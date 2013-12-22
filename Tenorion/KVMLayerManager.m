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
    self.layers = [[NSMutableArray alloc] init];
}

- (KVMLayer *)addLayer
{
    KVMLayer* layer = [[KVMLayer alloc] initWithFrame:CGRectMake(0, 0, 290, 380) AndColumns:self.layerSize AndColor:[self.colorsStack lastObject] AndTarget:self.target];
    [self.colorsStack removeLastObject];
    [self.layers addObject:layer];
    self.currLayerIndex++;
    
    return layer;
}

- (void)deleteLayerAtIndex:(int)index IsLastLayer:(BOOL)isLastLayer
{
    // In case garbage collection not immediate, turn all switches in layer off
    KVMLayer* layerToDelete = [self.layers objectAtIndex:index];
    [self setLayerOff:layerToDelete];
    
    // Remove layer from view and from array of layers
    [self.colorsStack addObject:layerToDelete.switchColor];
    [layerToDelete removeFromSuperview];
    [self.layers removeObjectAtIndex:index];
    
    // Current layer is the layer to the right of the deleted layer, if exists
    // Else current layer is the layer to the left of the deleted layer
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

- (KVMLayer *)getNextLayer
{
    self.currLayerIndex++;
    return [self.layers objectAtIndex:self.currLayerIndex];
}

- (KVMLayer *)getPreviousLayer
{
    self.currLayerIndex--;
    return [self.layers objectAtIndex:self.currLayerIndex];
}

- (KVMLayer *)getCurrentLayer
{
    return [self.layers objectAtIndex:self.currLayerIndex];
}

- (NSMutableArray *)getColumnOfCurrentLayer:(int)index
{
    // Get switches in specified column of current layer
    KVMLayer* currLayer = [self.layers objectAtIndex:self.currLayerIndex];
    return [currLayer.switches objectAtIndex:index];
}

- (NSMutableArray *)getColumn:(int)index
{
    NSMutableArray* currColumn = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.layers.count; i++)
    {
        // Accumulate all switches in current column from all layers except current layer
        if (i != self.currLayerIndex)
        {
            KVMLayer* layer = [self.layers objectAtIndex:i];
            [currColumn addObjectsFromArray:[layer.switches objectAtIndex:index]];
        }
    }
    return currColumn;
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

@end
