//
//  KVMPianoTones.m
//  Tenorion
//
//  Created by Kimberly Merrill on 12/4/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMPianoTones.h"

@implementation KVMPianoTones

-(id)init
{
    self = [super init];
    if (self)
    {
        [self loadTones];
    }
    return self;
}

-(void)loadTones
{
    NSArray* cTreble = [[NSArray alloc] initWithObjects: @"c5.wav", @"b4.wav", @"a4.wav", @"g4.wav", @"f4.wav", @"e4.wav", @"d4.wav", @"c4.wav", nil];
    NSArray* cBass = [[NSArray alloc] initWithObjects: @"c3.wav", @"b2.wav", @"a2.wav", @"g2.wav", @"f2.wav", @"e2.wav", @"d2.wav", @"c2.wav", nil];
    NSArray* cTones = [[NSArray alloc] initWithObjects:cTreble, cBass, nil];
    
    NSArray* gTreble = [[NSArray alloc] initWithObjects: @"g5.wav", @"f#5.wav", @"e5.wav", @"d5.wav", @"c5.wav", @"b4.wav", @"a4.wav", @"g4.wav", nil];
    NSArray* gBass = [[NSArray alloc] initWithObjects: @"g3.wav", @"f#3.wav", @"e3.wav", @"d3.wav", @"c3.wav", @"b2.wav", @"a2.wav", @"c2.wav", nil];
    NSArray* gTones = [[NSArray alloc] initWithObjects:gTreble, gBass, nil];
    
    NSArray* cMinorTreble = [[NSArray alloc] initWithObjects: @"c5.wav", @"bb4.wav", @"ab4.wav", @"g4.wav", @"f4.wav", @"eb4.wav", @"d4.wav", @"c4.wav", nil];
    NSArray* cMinorBass = [[NSArray alloc] initWithObjects: @"c3.wav", @"bb2.wav", @"ab2.wav", @"g2.wav", @"f2.wav", @"eb2.wav", @"d2.wav", @"c2.wav", nil];
    NSArray* cMinorTones = [[NSArray alloc] initWithObjects:cMinorTreble, cMinorBass, nil];
    
    self.tones = [[NSArray alloc] initWithObjects:cTones, gTones, cMinorTones, nil];
}

-(NSArray *)getTonesWithScale:(int)scale AndFrequency:(int)freq
{
    return [[self.tones objectAtIndex:scale] objectAtIndex:freq];
}

@end
