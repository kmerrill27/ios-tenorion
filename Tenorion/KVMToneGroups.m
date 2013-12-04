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
        self.tones = [[NSMutableArray alloc] init];
        [self initPianoTones];
        [self initDrumTones];
        [self initGuitarTones];
    }
    
    return self;
}

-(void)initPianoTones
{
    NSArray* pianoCTreble = [[NSArray alloc] initWithObjects: @"c5.wav", @"b4.wav", @"a4.wav", @"g4.wav", @"f4.wav", @"e4.wav", @"d4.wav", @"c4.wav", nil];
    NSArray* pianoCBass = [[NSArray alloc] initWithObjects: @"c3.wav", @"b2.wav", @"a2.wav", @"g2.wav", @"f2.wav", @"e2.wav", @"d2.wav", @"c2.wav", nil];
    
    NSArray* pianoGTreble = [[NSArray alloc] initWithObjects: @"g5.wav", @"f#5.wav", @"e5.wav", @"d5.wav", @"c5.wav", @"b4.wav", @"a4.wav", @"g4.wav", nil];
    NSArray* pianoGBass = [[NSArray alloc] initWithObjects: @"g3.wav", @"f#3.wav", @"e3.wav", @"d3.wav", @"c3.wav", @"b2.wav", @"a2.wav", @"c2.wav", nil];
    
    NSArray* pianoCMinorTreble = [[NSArray alloc] initWithObjects: @"c5.wav", @"bb4.wav", @"ab4.wav", @"g4.wav", @"f4.wav", @"eb4.wav", @"d4.wav", @"c4.wav", nil];
    NSArray* pianoCMinorBass = [[NSArray alloc] initWithObjects: @"c3.wav", @"bb2.wav", @"ab2.wav", @"g2.wav", @"f2.wav", @"eb2.wav", @"d2.wav", @"c2.wav", nil];
    
    NSMutableArray* pianoTones = [[NSMutableArray alloc] init];
    [self.tones addObject:pianoTones];
    
    NSMutableArray* trebleTones = [[NSMutableArray alloc] init];
    [pianoTones addObject:trebleTones];
    [trebleTones addObject:pianoCTreble];
    [trebleTones addObject:pianoGTreble];
    [trebleTones addObject:pianoCMinorTreble];
    
    NSMutableArray* bassTones = [[NSMutableArray alloc] init];
    [pianoTones addObject:bassTones];
    [bassTones addObject:pianoCBass];
    [bassTones addObject:pianoGBass];
    [bassTones addObject:pianoCMinorBass];
}

-(void)initGuitarTones
{
    NSArray* guitarCTreble = [[NSArray alloc] initWithObjects: @"c5.wav", @"b4.wav", @"a4.wav", @"g4.wav", @"f4.wav", @"e4.wav", @"d4.wav", @"c4.wav", nil];
    NSArray* guitarCBass = [[NSArray alloc] initWithObjects: @"c3.wav", @"b2.wav", @"a2.wav", @"g2.wav", @"f2.wav", @"e2.wav", @"d2.wav", @"c2.wav", nil];
    
    NSArray* guitarGTreble = [[NSArray alloc] initWithObjects: @"g5.wav", @"f#5.wav", @"e5.wav", @"d5.wav", @"c5.wav", @"b4.wav", @"a4.wav", @"g4.wav", nil];
    NSArray* guitarGBass = [[NSArray alloc] initWithObjects: @"g3.wav", @"f#3.wav", @"e3.wav", @"d3.wav", @"c3.wav", @"b2.wav", @"a2.wav", @"c2.wav", nil];
    
    NSArray* guitarCMinorTreble = [[NSArray alloc] initWithObjects: @"c5.wav", @"bb4.wav", @"ab4.wav", @"g4.wav", @"f4.wav", @"eb4.wav", @"d4.wav", @"c4.wav", nil];
    NSArray* guitarCMinorBass = [[NSArray alloc] initWithObjects: @"c3.wav", @"bb2.wav", @"ab2.wav", @"g2.wav", @"f2.wav", @"eb2.wav", @"d2.wav", @"c2.wav", nil];
    
    NSMutableArray* guitarTones = [[NSMutableArray alloc] init];
    [self.tones addObject:guitarTones];
    
    NSMutableArray* trebleTones = [[NSMutableArray alloc] init];
    [guitarTones addObject:trebleTones];
    [trebleTones addObject:guitarCTreble];
    [trebleTones addObject:guitarGTreble];
    [trebleTones addObject:guitarCMinorTreble];
    
    NSMutableArray* bassTones = [[NSMutableArray alloc] init];
    [guitarTones addObject:bassTones];
    [bassTones addObject:guitarCBass];
    [bassTones addObject:guitarGBass];
    [bassTones addObject:guitarCMinorBass];
}

-(void)initDrumTones
{
    NSMutableArray* drumTones = [[NSMutableArray alloc] initWithObjects: @"cymhigh.wav", @"hhat.wav", @"stick.wav", @"rim.wav", @"snare.wav", @"tomhi.wav", @"tommed.wav", @"kick.wav", nil];
    [self.tones addObject:drumTones];
}

-(NSArray *)getTonesWithInstrument:(int)instr AndScale:(int)scale AndFrequency:(int)freq
{
    // Guitar
    if (instr == 1)
    {
        return [self.tones objectAtIndex:instr];
    }
    else
    {
        return [[[self.tones objectAtIndex:instr] objectAtIndex:freq] objectAtIndex:scale];
    }
}

@end
