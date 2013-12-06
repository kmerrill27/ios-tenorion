//
//  KVMGuitarTones.m
//  Tenorion
//
//  Created by Kimberly Merrill on 12/4/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMGuitarTones.h"

@implementation KVMGuitarTones

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
    NSArray* cTreble = [[NSArray alloc] initWithObjects: @"c3guitar.wav", @"b3guitar.wav", @"a3guitar.wav", @"g3guitar.wav", @"f3guitar.wav", @"e3guitar.wav", @"d2guitar.wav", @"c2guitar.wav", nil];
    NSArray* cBass = [[NSArray alloc] initWithObjects: @"c2guitar.wav", @"b2guitar.wav", @"a2guitar.wav", @"g2guitar.wav", @"f2guitar.wav", @"e2guitar.wav", @"d1guitar.wav", @"c1guitar.wav", nil];
    NSArray* cTones = [[NSArray alloc] initWithObjects:cTreble, cBass, nil];
    
    NSArray* gTreble = [[NSArray alloc] initWithObjects: @"g3guitar.wav", @"f#3guitar.wav", @"e3guitar.wav", @"d2guitar.wav", @"c2guitar.wav", @"b2guitar.wav", @"a2guitar.wav", @"g2guitar.wav", nil];
    NSArray* gBass = [[NSArray alloc] initWithObjects: @"g2guitar.wav", @"f#2guitar.wav", @"e2guitar.wav", @"d1guitar.wav", @"c1guitar.wav", @"b1guitar.wav", @"a1guitar.wav", @"g1guitar.wav", nil];
    NSArray* gTones = [[NSArray alloc] initWithObjects:gTreble, gBass, nil];
    
    NSArray* cMinorTreble = [[NSArray alloc] initWithObjects: @"c3guitar.wav", @"bb3guitar.wav", @"ab3guitar.wav", @"g3guitar.wav", @"f3guitar.wav", @"eb2guitar.wav", @"d2guitar.wav", @"c2guitar.wav", nil];
    NSArray* cMinorBass = [[NSArray alloc] initWithObjects: @"c2guitar.wav", @"bb2guitar.wav", @"ab2guitar.wav", @"g2guitar.wav", @"f2guitar.wav", @"eb1guitar.wav", @"d1guitar.wav", @"c1guitar.wav", nil];
    NSArray* cMinorTones = [[NSArray alloc] initWithObjects:cMinorTreble, cMinorBass, nil];
    
    self.tones = [[NSArray alloc] initWithObjects:cTones, gTones, cMinorTones, nil];
}

-(NSArray *)getTonesWithScale:(int)scale AndFrequency:(int)freq
{
    return [[self.tones objectAtIndex:scale] objectAtIndex:freq];
}

@end
