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
    //NSLog(@"Switching");
    PlaceViewController *nextPlace = [self getNextPlace];
    /*[UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{ [self.view addSubview:nextPlace.view]; }
                    completion:NULL];*/
    /*[UIView transitionFromView:self.view toView:nextPlace.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished){
        //[self switchedToNewPlace:nextPlace];
    }];*/
    [self switchedToNewPlace:nextPlace];
}

- (void) finishedEditingSettings {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:[[MocapOverlayView alloc] initWithSuperView:self.view]];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
