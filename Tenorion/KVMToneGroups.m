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
        [self initGuitarTones];
        [self initDrumTones];
        [self initVocalTones];
    }
    
    return self;
}

-(void)initPianoTones
{
    NSArray* pianoCTreble = [[NSArray alloc] initWithObjects: @"c5.wav", @"b4.wav", @"a4.wav", @"g4.wav", @"f4.wav", @"e4.wav", @"d4.wav", @"c4.wav", nil];
    NSArray* pianoCBass = [[NSArray alloc] initWithObjects: @"c3.wav", @"b2.wav", @"a2.wav", @"g2.wav", @"f2.wav", @"e2.wav", @"d2.wav", @"c2.wav", nil];
    
    NSArray* pianoGTreble = [[NSArray alloc] initWithObjects: @"g4.wav", @"a4.wav", @"b4.wav", @"c5.wav", @"d5.wav", @"e5.wav", @"f#5.wav", @"g5.wav", nil];
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
    
}

-(void)initDrumTones
{
    
}

-(void)initVocalTones
{
    
}

-(NSArray *)getTonesWithInstrument:(int)instr AndScale:(int)scale AndFrequency:(int)freq
{
    NSMutableArray* instrArr = [self.tones objectAtIndex:instr];
    NSLog(@"%d", instrArr.count);
    NSMutableArray* freqArr = [instrArr objectAtIndex:freq];
    NSLog(@"%d", freqArr.count);
    return [[[self.tones objectAtIndex:instr] objectAtIndex:freq] objectAtIndex:scale];
}

@end
