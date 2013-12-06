//
//  KVMDrumTones.m
//  Tenorion
//
//  Created by Kimberly Merrill on 12/4/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMDrumTones.h"

@implementation KVMDrumTones

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
    self.tones = [[NSArray alloc] initWithObjects: @"cymhigh.wav", @"hhat.wav", @"stick.wav", @"rim.wav", @"snare.wav", @"tomhi.wav", @"tommed.wav", @"kick.wav", nil];
}

-(NSArray *)getTonesWithScale:(int)scale AndFrequency:(int)freq
{
    return self.tones;
}

@end
