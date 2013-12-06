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
        [self loadTones];
    }
    
    return self;
}

-(void)loadTones
{
    KVMPianoTones* pianoTones = [[KVMPianoTones alloc] init];
    KVMDrumTones* drumTones = [[KVMDrumTones alloc] init];
    KVMGuitarTones* guitarTones = [[KVMGuitarTones alloc] init];
    self.tones = [[NSMutableArray alloc] initWithObjects:pianoTones, drumTones, guitarTones, nil];
}

-(NSArray *)getTonesWithInstrument:(int)instr AndScale:(int)scale AndFrequency:(int)freq
{
    return [[self.tones objectAtIndex:instr] getTonesWithScale:scale AndFrequency:freq];
}

@end
