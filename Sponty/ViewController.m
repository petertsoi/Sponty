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

#import "Checkbox.h"

#import "MocapOverlayView.h"

@implementation ViewController

@synthesize myLocation, locationManager;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    myLocation = newLocation.coordinate;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

- (CLLocationCoordinate2D) getLocation {
    return myLocation;
}

#pragma mark - View lifecycle

- (IBAction) startButtonPressed:(id) sender {
    placeVC = [[PlaceViewController alloc] initWithNibName:@"PlaceViewController" bundle:[NSBundle mainBundle] withController:self];
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

- (IBAction) selectedFriends:(id)sender {
    [friendsCheckbox setChecked:YES];
    [dateCheckbox setChecked:NO];
}

- (IBAction) selectedDate:(id)sender {
    [friendsCheckbox setChecked:NO];
    [dateCheckbox setChecked:YES];
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
    
    [friendsCheckbox setChecked:YES];
    [dateCheckbox setChecked:NO];
    
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.delegate = self; // send loc updates to myself
    [self.locationManager startUpdatingLocation];
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

- (void) dealloc { 
    [locationManager release];
    [super dealloc];
}

@end
