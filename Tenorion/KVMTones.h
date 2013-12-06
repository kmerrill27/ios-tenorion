//
//  KVMTones.h
//  Tenorion
//
//  Created by Kimberly Merrill on 12/4/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KVMTones <NSObject>

-(id)init;
-(void)loadTones;
-(NSArray *)getTonesWithScale:(int)scale AndFrequency:(int)freq;

@end
