//
//  KVMAppDelegate.h
//  Tenorion
//
//  Created by Kimberly Merrill on 11/2/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "KVMMainViewController.h"

@interface KVMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) KVMMainViewController *mainViewController;

@end
