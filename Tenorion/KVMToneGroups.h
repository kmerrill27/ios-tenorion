//
//  KVMToneGroups.h
//  Tenorion
//
//  Created by Kimberly Merrill on 12/3/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVMTones.h"
#import "KVMPianoTones.h"
#import "KVMGuitarTones.h"
#import "KVMDrumTones.h"

@interface KVMToneGroups : NSObject

@property (strong, nonatomic) NSMutableArray* tones;

-(id)init;
-(NSArray *)getTonesWithInstrument:(int)instr AndScale:(int)scale AndFrequency:(int)freq;

@end
