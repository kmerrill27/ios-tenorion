//
//  KVMTone.h
//  Tenorion
//
//  Created by Kimberly Merrill on 11/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <AudioToolbox/AudioServices.h>
#import <Foundation/Foundation.h>

@interface KVMTone : NSObject

@property SystemSoundID toneId;

- (id)initWithTone:(NSString *)file;
- (void)playTone;

@end
