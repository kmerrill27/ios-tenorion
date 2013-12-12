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
    
    if (self.currLayerIndex-1 >= 0)
    {
        [self setCurrentLayerFlagsAt:self.currLayerIndex-1 To:NO];
    }
    
    return layer;
}

- (void)deleteLayerAtIndex:(int)index IsLastLayer:(BOOL)isLastLayer
{
    KVMLayer* layerToDelete = [self.layers objectAtIndex:index];
    [self setLayerOff:layerToDelete];
    [self.colorsStack addObject:[layerToDelete getColor]];
    [layerToDelete removeFromSuperview];
    [self setCurrentLayerFlagsAt:index To:NO];
    [self.layers removeObjectAtIndex:index];
    
    if (isLastLayer)
    {
        self.currLayerIndex = index - 1;
    }
    else
    {
        NSMutableArray* tempLayers = [[NSMutableArray alloc] init];
        for (KVMLayer* layer in self.layers)
        {
            [tempLayers addObject:layer];
        }
    
        self.layers = tempLayers;
        self.currLayerIndex = index;
    }
    
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
        NSMutableArray* layerColumn = [[self.layers objectAtIndex:i] getColumn:self.currColumnIndex];
        [currColumn addObjectsFromArray:layerColumn];
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
