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
#import "FeedbackViewController.h"

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

#pragma mark - View lifecycle

- (IBAction) startButtonPressed:(id) sender {
    [TestFlight passCheckpoint:@"Pressed 'Be Spontaneous' button."];
    if (placeVC) {
        [placeVC release];
        placeVC = nil;
    }
    placeVC = [[PlaceViewController alloc] initWithNibName:@"PlaceViewController" 
                                                    bundle:[NSBundle mainBundle] 
                                            withController:self];
    [self switchedToNewPlace:placeVC];
}

- (IBAction) showSettings:(id) sender {
    SettingsViewController *settingsVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:[NSBundle mainBundle]];
    settingsVC.delegate = self;
    [self presentModalViewController:settingsVC animated:YES];
}

- (IBAction) selectedFriends:(id)sender {
    if (!friendsCheckbox.checked) {
        [friendsCheckbox setChecked:YES];
        [dateCheckbox setChecked:NO];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"withFriends"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"onDate"];
    } else {
        [friendsCheckbox setChecked:NO];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"withFriends"];
    }
    
}

- (IBAction) selectedDate:(id)sender {
    if (!dateCheckbox.checked) {
        [friendsCheckbox setChecked:NO];
        [dateCheckbox setChecked:YES];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"withFriends"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"onDate"];
    } else {
        [dateCheckbox setChecked:NO];
         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"onDate"];
    }
    
}

- (IBAction) showFeedback:(id)sender {
    FeedbackViewController *settingsVC = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:[NSBundle mainBundle]];
    settingsVC.delegate = self;
    [self presentModalViewController:settingsVC animated:YES];
}

- (void)swipedLeft:(id)sender {
    if (placeVC) {
        [TestFlight passCheckpoint:@"Swiped from splash to cached results"];
        [self.navigationController pushViewController:placeVC animated:YES];
    }
}

- (void) switchedToNewPlace:(PlaceViewController *)newPlace {
    placeVC = newPlace;
    placeVC.delegate = self;
    [self.navigationController pushViewController:newPlace animated:YES];
    
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
    
    gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    [self selectedFriends:nil];
    
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.delegate = self; // send loc updates to myself
    [self.locationManager startUpdatingLocation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) dealloc { 
    [locationManager release];
    [gestureRecognizer release];
    [super dealloc];
}

@end
