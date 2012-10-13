//
//  HappinessViewController.m
//  Happiness
//
//  Created by Nilesh Karia on Jul/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

//NOTE - Implementing delegate here as we don't want to expose it in the header 
//as public API
@interface HappinessViewController() <FaceViewDataSource>

@property (nonatomic, weak) IBOutlet FaceView *faceView;

@end

@implementation HappinessViewController

@synthesize happiness = _happiness;
@synthesize faceView  = _faceView;

- (void) setHappiness:(int)happiness
{
    _happiness = happiness;
    
    [self.faceView setNeedsDisplay];
}

//NOTE - We must have addGestureRecognizer when setting the faceView
//else we will not be able to register any gestures.
- (void) setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];

    //NOTE - The target is self and NOT self.faceView since faceView cannot access the dataSource
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];
    
    self.faceView.dataSource = self;
}

- (void) handleHappinessGesture:(UIPanGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) ||
       (gesture.state == UIGestureRecognizerStateEnded))
    {
        //Work in target view faceView
        CGPoint translation = [gesture translationInView:self.faceView];
        
        //Divide by constant
        self.happiness -= translation.y / 2; 
        
        //Reset pan gesture translation
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

- (float) smileForFaceView:(FaceView *)sender
{
    return (self.happiness - 50) / 50.0;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

/*
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}
*/

@end
