//
//  KVMMainViewController.h
//  Tenorion
//
//  Created by Kimberly Merrill on 11/2/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "KVMLayerManager.h"
#import "KVMPlayer.h"

@interface KVMMainViewController : UIViewController

@property (strong, nonatomic) NSMutableArray* layerColors;
@property (strong, nonatomic) KVMLayerManager* layerManager;
@property (strong, nonatomic) KVMPlayer* player;

@property (strong, nonatomic) IBOutlet UISegmentedControl* layerControl;
@property (strong, nonatomic) IBOutlet UIView* switchBoardView;
@property (strong, nonatomic) IBOutlet UIImageView* arrowView;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer* panRecognizer;

- (IBAction)didPan:(UIPanGestureRecognizer *)recognizer;

@end
