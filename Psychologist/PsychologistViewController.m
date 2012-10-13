//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by Nilesh Karia on Oct/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController()

@property (nonatomic) int diagnosis;

@end

@implementation PsychologistViewController

@synthesize diagnosis = _diagnosis;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void) setAndShowDiagnosis:(int)diagnosis
{
    _diagnosis = diagnosis;
    
    //NOTE - Segue here
    [self performSegueWithIdentifier:@"ShowDiagnosis" sender:self];
}


//NOTE - This must be implemented to perform actions in the connected seques
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"Identifier %@", segue.identifier);
    
    if([segue.identifier isEqualToString:@"ShowDiagnosis"])
    {
        [segue.destinationViewController setHappiness:self.diagnosis];
    }
    else if([segue.identifier isEqualToString:@"Celebrity"])
    {
        [segue.destinationViewController setHappiness:100];
    }
    else if([segue.identifier isEqualToString:@"Serious"])
    {
        [segue.destinationViewController setHappiness:20];
    }
    else if([segue.identifier isEqualToString:@"TV Kook"])
    {
        [segue.destinationViewController setHappiness:50];
    }
}

//NOTE - Connect UINavigationController

- (IBAction)racing 
{
    [self setAndShowDiagnosis:100];
}

- (IBAction)crashing 
{
    [self setAndShowDiagnosis:10];
}

- (IBAction)peaceful 
{
    [self setAndShowDiagnosis:70];
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
