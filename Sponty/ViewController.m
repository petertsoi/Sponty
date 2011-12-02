//
//  ViewController.m
//  Sponty
//
//  Created by Peter Tsoi on 11/27/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "ViewController.h"

#import "PlaceViewController.h"
#import "SettingsViewController.h"

#import "MocapOverlayView.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (IBAction) startButtonPressed:(id) sender {
    placeVC = [[PlaceViewController alloc] initWithNibName:@"PlaceViewController" bundle:[NSBundle mainBundle]];
    [self.view setBackgroundColor:[UIColor blackColor]];
    for (int i = 0; i <= [[self.view subviews] count]; ++i) {
        [[[self.view subviews] objectAtIndex:0] removeFromSuperview];
    }
    [self switchedToNewPlace:placeVC];
}

- (IBAction) showSettings:(id) sender {
    SettingsViewController *settingsVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:[NSBundle mainBundle]];
    settingsVC.delegate = self;
    [self presentModalViewController:settingsVC animated:YES];
}

- (void) switchedToNewPlace:(PlaceViewController *)newPlace {
    placeVC = newPlace;
    placeVC.delegate = self;
    //self.view = newPlace.view;
    [self.view insertSubview:newPlace.view atIndex:[[self.view subviews] count] -1];
    
    
}

- (PlaceViewController *) getNextPlace {
    PlaceViewController *next = [[PlaceViewController alloc] initWithNibName:@"PlaceViewController" bundle:[NSBundle mainBundle]];
    next.delegate = self;
    return next;
}

- (void) showNextPlace {
    PlaceViewController *nextPlace = [self getNextPlace];
    [self switchedToNewPlace:nextPlace];
}

- (void) finishedEditingSettings {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgpattern"]]];
    [self.view addSubview:[[MocapOverlayView alloc] initWithSuperView:self.view]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
