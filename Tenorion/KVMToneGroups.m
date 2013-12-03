//
//  KVMToneGroups.m
//  Tenorion
//
//  Created by Kimberly Merrill on 12/3/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMToneGroups.h"

@implementation KVMToneGroups

-(id)init
{
    self = [super init];
    
    if (self)
    {
        [self initPianoTones];
        [self initGuitarTones];
        [self initDrumTones];
        [self initVocalTones];
    }
    
    return self;
}

-(void)initPianoTones
{
    self.pianoCTreble = [[NSArray alloc] initWithObjects: @"c4shorter.wav", @"d4shorter.wav", @"e4shorter.wav", @"f4shorter.wav", @"g4shorter.wav", @"a4shorter.wav", @"b4shorter.wav", @"c5shorter.wav", nil];
    self.pianoCBass = [[NSArray alloc] initWithObjects: @"c2shorter.wav", @"d2shorter.wav", @"e2shorter.wav", @"f2shorter.wav", @"g2shorter.wav", @"a2shorter.wav", @"b2shorter.wav", @"c3shorter.wav", nil];
    
    self.pianoGTreble = [[NSArray alloc] initWithObjects: @"g4shorter.wav", @"a4shorter.wav", @"b4shorter.wav", @"c5shorter.wav", @"d5shorter.wav", @"e5shorter.wav", @"f#5shorter.wav", @"g5shorter.wav", nil];
    self.pianoGBass = [[NSArray alloc] initWithObjects: @"g2shorter.wav", @"a2shorter.wav", @"b2shorter.wav", @"c3shorter.wav", @"d3shorter.wav", @"e3shorter.wav", @"f#3shorter.wav", @"g3shorter.wav", nil];
    
    self.pianoCMinorTreble = [[NSArray alloc] initWithObjects: @"c4shorter.wav", @"d4shorter.wav", @"eb4shorter.wav", @"f4shorter.wav", @"g4shorter.wav", @"ab4shorter.wav", @"bb4shorter.wav", @"c5shorter.wav", nil];
    self.pianoCMinorBass = [[NSArray alloc] initWithObjects: @"c2shorter.wav", @"d2shorter.wav", @"eb2shorter.wav", @"f2shorter.wav", @"g2shorter.wav", @"ab2shorter.wav", @"bb2shorter.wav", @"c3shorter.wav", nil];
}

-(void)initGuitarTones
{
    
}

-(void)initDrumTones
{
    
}

-(void)initVocalTones
{
    
}

@end
