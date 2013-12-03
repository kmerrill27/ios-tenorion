//
//  KVMToneGroups.h
//  Tenorion
//
//  Created by Kimberly Merrill on 12/3/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVMToneGroups : NSObject

@property (strong, nonatomic) NSArray* pianoCTreble;
@property (strong, nonatomic) NSArray* pianoCBass;
@property (strong, nonatomic) NSArray* pianoGTreble;
@property (strong, nonatomic) NSArray* pianoGBass;
@property (strong, nonatomic) NSArray* pianoCMinorTreble;
@property (strong, nonatomic) NSArray* pianoCMinorBass;

-(id)init;

@end
