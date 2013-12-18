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
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.layerColors = [[NSMutableArray alloc] initWithObjects:[UIColor colorWithRed:0 green:238.0/255.0 blue:118.0/255.0 alpha:1], [UIColor whiteColor], [UIColor blueColor], [UIColor colorWithRed:238.0/255.0 green:48.0/255.0 blue:167.0/255.0 alpha:1], nil];
    self.layerManager = [[KVMLayerManager alloc] initWithColumns:8 AndColors:self.layerColors AndTarget:self];
    self.player = [[KVMPlayer alloc] initWithLayerManager:self.layerManager];
}

- (IBAction)didPan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint velocity = [recognizer velocityInView:self.view];
    CGPoint location = [recognizer locationInView:self.view];
    
    if (CGRectContainsPoint(self.arrowView.frame, location))
    {
        // Upward pan presents option controller
        [recognizer setEnabled:NO];
        [self panOptions:velocity];
    }
    else if (CGRectContainsPoint(self.switchBoardView.frame, location))
    {
        // Side pan moves between layers
        [self panLayer:velocity];
    }
}

- (void)panLayer:(CGPoint)velocity
{
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

- (void)panOptions:(CGPoint)velocity
{
    // Up gesture
    if (velocity.y < 0)
    {
        [self presentOptionsViewController];
    }
}

- (void)goToPreviousLayer
{
    KVMLayer* previousLayer = [self.layerManager getPreviousLayerToPan:YES];
    [self.switchBoardView bringSubviewToFront:previousLayer];
    
    [self tintElements:previousLayer.switchColor];
    
    self.layerControl.selectedSegmentIndex = self.layerControl.selectedSegmentIndex - 1;
}

- (void)goToNextLayer
{
    KVMLayer* nextLayer = [self.layerManager getNextLayerToPan:YES];
    [self.switchBoardView bringSubviewToFront:nextLayer];
    
    [self tintElements:nextLayer.switchColor];
    
    self.layerControl.selectedSegmentIndex = self.layerControl.selectedSegmentIndex + 1;
}

- (void)addNewLayer
{
    KVMLayer* layer = [self.layerManager addLayer];
    [layer setupOptionsControllerWithDismissAction:@selector(dismissOptionsController) AndDeleteAction:@selector(deleteCurrentLayer)];
    [self.switchBoardView addSubview:layer];
    
    [self tintElements:layer.switchColor];
    
    // Update layer segment control
    int numLayers = [self.layerControl numberOfSegments];
    [self.layerControl insertSegmentWithTitle:@"" atIndex:numLayers animated:YES];
    self.layerControl.selectedSegmentIndex = numLayers;
}

- (void)deleteCurrentLayer
{
    int layerToDelete = self.layerControl.selectedSegmentIndex;
    BOOL isLastLayer = layerToDelete == [self.layerControl numberOfSegments] - 1;
    [self.layerManager deleteLayerAtIndex:layerToDelete IsLastLayer:isLastLayer];
    
    if (isLastLayer)
    {
        [self deleteLastLayer:layerToDelete];
    }
    else
    {
        [self deleteInBetweenLayer:layerToDelete];
    }
    
    [self tintElements:[self.layerManager getCurrentLayer].switchColor];
}

- (void)deleteInBetweenLayer:(int)layerToDelete
{
    int currIndex = 0;
    int numSegments = [self.layerControl numberOfSegments];
    
    // Move all layers left one to keep segment control and layer manager consistent
    for (int i = 0; i < numSegments; i++)
    {
        if (i != layerToDelete)
        {
            [self.layerControl removeSegmentAtIndex:currIndex animated:NO];
            [self.layerControl insertSegmentWithTitle:@"" atIndex:currIndex animated:NO];
            currIndex++;
        }
    }
    
    [self.layerControl removeSegmentAtIndex:numSegments-1 animated:NO];
    self.layerControl.selectedSegmentIndex = layerToDelete;
}

- (void)deleteLastLayer:(int)layerToDelete
{
    [self.layerControl removeSegmentAtIndex:layerToDelete animated:YES];
    if ([self.layerControl numberOfSegments] == 0)
    {
        // If only layer, re-add layer (must always have at least one layer)
        [self addNewLayer];
    }
    else
    {
        self.layerControl.selectedSegmentIndex = layerToDelete-1;
    }
}

- (void)tintElements:(UIColor *)color
{
    // Change color of arrow and segment control graphic
    self.layerControl.tintColor = color;
    UIImage* imageForRendering = [self.arrowView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.arrowView.image = imageForRendering;
    self.arrowView.tintColor = color;
}

- (void)presentOptionsViewController
{
    CGRect mainrect = self.view.bounds;
    CGRect newRect = CGRectMake(0, mainrect.size.height, mainrect.size.width, mainrect.size.height);
    
    KVMOptionsViewController* currOptionsController = [self.layerManager getCurrentLayer].optionsController;
    [self.view addSubview:currOptionsController.view];
    currOptionsController.view.frame = newRect;
    
    [UIView animateWithDuration:0.5 animations:^{
        currOptionsController.view.frame = mainrect;
    } completion:nil];
}

- (void)dismissOptionsController
{
    CGRect mainrect = self.view.bounds;
    CGRect newRect = CGRectMake(0, mainrect.size.height, mainrect.size.width, 0);
    
    KVMOptionsViewController* currOptionsController = [self.layerManager getCurrentLayer].optionsController;
    [UIView animateWithDuration:0.5 animations:^{
        currOptionsController.view.frame = newRect;
    } completion:^(BOOL finished) {
        [currOptionsController.view removeFromSuperview];
        [currOptionsController setIsBeingDismissed:NO];
        [self.panRecognizer setEnabled:YES];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.layerControl removeAllSegments];
    [self addNewLayer];
    
    // Start main animation loop
    [self.player startPlayback];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
