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
        self.layerColors = [[NSMutableArray alloc] initWithObjects:[UIColor cyanColor],[UIColor yellowColor], [UIColor magentaColor], [UIColor whiteColor], nil];
        self.layerManager = [[KVMLayerManager alloc] initWithColumns:12 AndColors:self.layerColors];
        self.player = [[KVMPlayer alloc] initWithLayerManager:self.layerManager];
    }
    return self;
}

- (IBAction)didPan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint velocity = [recognizer velocityInView:self.view];
    CGPoint location = [recognizer locationInView:self.view];
    
    if (CGRectContainsPoint(self.arrowView.frame, location))
    {
        [recognizer setEnabled:NO];
        [self panOptions:velocity];
    }
    else if (CGRectContainsPoint(self.switchBoardView.frame, location))
    {
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
    if (velocity.y < 0 && self.optionsController == nil)
    {
        [self presentOptionsViewController];
    }
}

- (void)goToPreviousLayer
{
    KVMLayer* previousLayer = [self.layerManager getPreviousLayer];
    [self.switchBoardView bringSubviewToFront:previousLayer];
    
    [self tintElements:[previousLayer getColor]];
    
    self.layerControl.selectedSegmentIndex = self.layerControl.selectedSegmentIndex - 1;
}

- (void)goToNextLayer
{
    KVMLayer* nextLayer = [self.layerManager getNextLayer];
    [self.switchBoardView bringSubviewToFront:nextLayer];
    
    [self tintElements:[nextLayer getColor]];
    
    self.layerControl.selectedSegmentIndex = self.layerControl.selectedSegmentIndex + 1;
}

- (void)addNewLayer
{
    KVMLayer* layer = [self.layerManager addLayer];
    [self.switchBoardView addSubview:layer];
    
    [self tintElements:[layer getColor]];
    
    int numLayers = [self.layerControl numberOfSegments];
    [self.layerControl insertSegmentWithTitle:@"" atIndex:numLayers animated:YES];
    self.layerControl.selectedSegmentIndex = numLayers;
}

- (void)deleteLayer
{
    int layerToDelete = self.layerControl.selectedSegmentIndex;
    BOOL isLastLayer = layerToDelete == [self.layerControl numberOfSegments] - 1;
    [self.layerManager deleteLayerAtIndex:layerToDelete IsLastLayer:isLastLayer];
    
    if (isLastLayer)
    {
        [self.layerControl removeSegmentAtIndex:layerToDelete animated:YES];
        if ([self.layerControl numberOfSegments] == 0)
        {
            [self addNewLayer];
        }
        else
        {
            self.layerControl.selectedSegmentIndex = layerToDelete-1;
        }
    }
    else
    {
        int currIndex = 0;
        for (int i = 0; i < [self.layerControl numberOfSegments]; i++)
        {
            if (i != layerToDelete)
            {
                [self.layerControl removeSegmentAtIndex:currIndex animated:NO];
                [self.layerControl insertSegmentWithTitle:@"" atIndex:currIndex animated:NO];
                currIndex++;
            }
        }
        
        [self.layerControl removeSegmentAtIndex:[self.layerControl numberOfSegments]-1 animated:NO];
        self.layerControl.selectedSegmentIndex = layerToDelete;
    }
    
    [self tintElements:[[self.layerManager getCurrentLayer] getColor]];
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
    [self.switchBoardView addSubview:layer];
    
    [self.layerControl insertSegmentWithTitle:@"" atIndex:0 animated:YES];
    self.layerControl.selectedSegmentIndex = 0;
    
    [self tintElements:[layer getColor]];
    
    [self.player startPlayback];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentOptionsViewController
{
    self.optionsController = [[KVMOptionsViewController alloc] initWithNibName:@"KVMOptionsViewController" WithColor:[self.arrowView tintColor]AndTarget:self AndAction:@selector(dismissOptionsController) AndDeleteAction:@selector(deleteLayer)];
    
    CGRect mainrect = self.view.bounds;
    CGRect newRect = CGRectMake(0, mainrect.size.height, mainrect.size.width, mainrect.size.height);
    
    [self.view addSubview:self.optionsController.view];
    self.optionsController.view.frame = newRect;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.optionsController.view.frame = mainrect;
    } completion:nil];
}

-(void)dismissOptionsController
{
    CGRect mainrect = self.view.bounds;
    CGRect newRect = CGRectMake(0, mainrect.size.height, mainrect.size.width, 0);

    [UIView animateWithDuration:0.5 animations:^{
        self.optionsController.view.frame = newRect;
    } completion:^(BOOL finished) {
        [self.optionsController.view removeFromSuperview];
        self.optionsController = nil;
        [self.panRecognizer setEnabled:YES];
    }];
}

@end
