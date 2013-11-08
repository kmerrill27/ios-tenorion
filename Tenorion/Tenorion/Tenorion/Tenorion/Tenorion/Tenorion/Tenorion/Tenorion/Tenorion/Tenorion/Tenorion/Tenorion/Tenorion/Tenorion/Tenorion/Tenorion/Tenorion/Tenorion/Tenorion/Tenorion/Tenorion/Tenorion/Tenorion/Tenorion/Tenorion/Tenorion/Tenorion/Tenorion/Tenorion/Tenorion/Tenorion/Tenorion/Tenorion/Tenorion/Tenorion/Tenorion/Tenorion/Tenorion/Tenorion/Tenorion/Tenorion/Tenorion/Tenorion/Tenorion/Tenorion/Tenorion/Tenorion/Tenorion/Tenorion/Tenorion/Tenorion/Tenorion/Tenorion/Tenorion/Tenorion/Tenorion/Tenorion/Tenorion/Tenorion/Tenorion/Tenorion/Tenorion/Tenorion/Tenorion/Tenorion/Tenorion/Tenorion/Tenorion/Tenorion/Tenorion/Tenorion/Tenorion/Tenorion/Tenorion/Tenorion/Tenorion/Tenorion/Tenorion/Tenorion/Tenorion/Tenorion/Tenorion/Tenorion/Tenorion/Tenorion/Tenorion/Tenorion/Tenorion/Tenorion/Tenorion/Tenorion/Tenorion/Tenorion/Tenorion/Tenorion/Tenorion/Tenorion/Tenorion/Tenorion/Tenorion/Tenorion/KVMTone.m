//
//  KVMTone.m
//  Tenorion
//
//  Created by Kimberly Merrill on 11/6/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMTone.h"

@implementation KVMTone

- (id)initWithTone:(NSString *)file
{
    self = [super init];
    if (self) {
        NSURL* fileURL = [[NSBundle mainBundle] URLForResource:file withExtension:nil];
        if (fileURL != nil)
        {
            SystemSoundID soundId;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &soundId);
            if (error == kAudioServicesNoError)
            {
                self.toneId = soundId;
            }
        }
    }
    return self;
}

- (void)playTone
{
    if (self.toneId)
    {
        AudioServicesPlaySystemSound(self.toneId);
    }
}

@end
