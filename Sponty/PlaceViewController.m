//
//  PlaceViewController.m
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "PlaceViewController.h"

#import "ViewController.h"
#import "PlaceDetailView.h"
#import "PlaceMapView.h"

@implementation PlaceViewController

@synthesize delegate = mDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        counter = 0;
        // Custom initialization
        detailView = [[[NSBundle mainBundle] loadNibNamed:@"PlaceDetailView" owner:self options:nil] objectAtIndex:0];
        [detailView retain];
        
        [detailView setPlaceName:@"Santa Cruz Boardwalk"];
        [detailView setFeatureImage:[UIImage imageNamed:@"boardwalk"]];
        [detailView setTimeSuggest:@"It's always open."];
        [detailView setWeatherSuggest:@"It's a gorgeous 68º now. Go enjoy a walk on the boardwalk."];
        [detailView setDistanceSuggest:@"Best of all, its only 0.2 miles away!"];
        
        [self.view addSubview:detailView];
        //[self.view addSubview:[[MocapOverlayView alloc] initWithSuperView:self.view]];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) hideMapView {
    NSLog(@"Hide map");
    [UIView transitionFromView:mapView toView:detailView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
        
    }];
    
}

- (IBAction)showMapView:(id)sender {
    mapView = [[[NSBundle mainBundle] loadNibNamed:@"PlaceMapView" owner:self options:nil] objectAtIndex:0];
    mapView.delegate = self;
    [UIView transitionFromView:detailView toView:mapView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
        [mapView roundCorners];
    }];
    //[self.view addSubview:[[MocapOverlayView alloc] initWithSuperView:self.view]];
}

- (IBAction)showNextPlace:(id)sender {
    ++counter;
    PlaceDetailView * newDetailView = [[[NSBundle mainBundle] loadNibNamed:@"PlaceDetailView" owner:self options:nil] objectAtIndex:0];
    [newDetailView retain];
    
    switch (counter) {
        case 1:
            [newDetailView setPlaceName:@"Santa Cruz Scoop"];
            [newDetailView setFeatureImage:[UIImage imageNamed:@"icecream"]];
            [newDetailView setTimeSuggest:@"It's open for another 6 hours and 12 minutes."];
            [newDetailView setWeatherSuggest:@"On a chilly day like this, hot fudge is the way to go."];
            [newDetailView setDistanceSuggest:@"It's a walkable 0.1 miles away."];
            break;

        case 2:
            [newDetailView setPlaceName:@"Boardwalk Bowl"];
            [newDetailView setFeatureImage:[UIImage imageNamed:@"bowling"]];
            [newDetailView setTimeSuggest:@"It's open for another 5 hours and 35 minutes."];
            [newDetailView setWeatherSuggest:@"It's getting chilly, head over to Boardwalk Bowl to grab a lane."];
            [newDetailView setDistanceSuggest:@"It's a short car ride away (0.4 miles)."];
            break;

        case 3:
            [newDetailView setPlaceName:@"Woodstock Pizza"];
            [newDetailView setFeatureImage:[UIImage imageNamed:@"pizza"]];
            [newDetailView setTimeSuggest:@"It's open for another 6 hours and 12 minutes."];
            [newDetailView setWeatherSuggest:@"There's nothing hot slice of pesto pizza can't solve!"];
            [newDetailView setDistanceSuggest:@"You could walk there, its 0.3 miles away."];
            break;

        case 4:
            [newDetailView setPlaceName:@"Pacific Street"];
            [newDetailView setFeatureImage:[UIImage imageNamed:@"pacific"]];
            [newDetailView setTimeSuggest:@"It's always open."];
            [newDetailView setWeatherSuggest:@"Go enjoy this brisk night by walking under the lights."];
            [newDetailView setDistanceSuggest:@"You're practically there!"];
            break;
            
        default:
            [newDetailView setPlaceName:@"Fenton's Ice Cream"];
            [newDetailView setFeatureImage:[UIImage imageNamed:@"icecream"]];
            break;
    }
    
    [UIView transitionFromView:detailView toView:newDetailView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished){
        [detailView release];
        detailView = newDetailView;
    }];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
*/
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
