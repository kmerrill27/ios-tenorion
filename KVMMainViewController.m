//
//  KVMMainViewController.m
//  Tenorion
//
//  Created by Kimberly Merrill on 11/2/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMMainViewController.h"

@interface KVMMainViewController ()

@end

@implementation KVMMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.layerColors = [[NSMutableArray alloc] initWithObjects:[UIColor magentaColor], [UIColor whiteColor], nil];
        self.layerManager = [[KVMLayerManager alloc] initWithColumns:12 AndColors:self.layerColors];
        self.player = [[KVMPlayer alloc] initWithLayerManager:self.layerManager];
    }
    return self;
}

- (IBAction)didPanLayer:(UIPanGestureRecognizer *)recognizer
{
    CGPoint velocity = [recognizer velocityInView:self.view];
    if (velocity.x > 0)
    {
        // Right gesture
        if ([self.layerManager hasPreviousLayer])
        {
            [self goToPreviousLayer];
        }
    }
    else
    {
        // Left gesture
        if ([self.layerManager hasNextLayer])
        {
            [self goToNextLayer];
        }
        else if ([self.layerManager canAddLayer])
        {
            [self addNewLayer];
        }
    }
}

- (void)goToPreviousLayer
{
    KVMLayer* previousLayer = [self.layerManager getPreviousLayer];
    [self.view bringSubviewToFront:previousLayer];
    
    [self tintElements:[previousLayer getColor]];
    
    self.layerControl.selectedSegmentIndex = self.layerControl.selectedSegmentIndex - 1;
}

- (void)goToNextLayer
{
    KVMLayer* nextLayer = [self.layerManager getNextLayer];
    [self.view bringSubviewToFront:nextLayer];
    
    [self tintElements:[nextLayer getColor]];
    
    self.layerControl.selectedSegmentIndex = self.layerControl.selectedSegmentIndex + 1;
}

- (void)addNewLayer
{
    KVMLayer* layer = [self.layerManager addLayer];
    [self.view addSubview:layer];
    
    [self tintElements:[layer getColor]];
    
    int numLayers = [self.layerControl numberOfSegments];
    [self.layerControl insertSegmentWithTitle:[NSString stringWithFormat:@"%d", numLayers+1] atIndex:numLayers animated:YES];
    self.layerControl.selectedSegmentIndex = numLayers;
}

- (void)tintElements:(UIColor *)color
{
    self.layerControl.tintColor = color;
    UIImage* imageForRendering = [self.arrowView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.arrowView.image = imageForRendering;
    self.arrowView.tintColor = color;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.layerControl removeAllSegments];
    KVMLayer* layer = [self.layerManager addLayer];
    [self.view addSubview:layer];
    
    [self.layerControl insertSegmentWithTitle:@"1" atIndex:0 animated:YES];
    self.layerControl.selectedSegmentIndex = 0;

    [self tintElements:[layer getColor]];

    [self.player startPlayback];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
