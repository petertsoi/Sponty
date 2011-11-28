//
//  PlaceViewController.m
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "PlaceViewController.h"

#import "ViewController.h"
#import "PlaceMapView.h"

@implementation PlaceViewController

@synthesize delegate = mDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
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
    mapView = [[PlaceMapView alloc] initWithFrame:self.view.frame];
    [mapView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PlacePageBG"]]];
    detailView=self.view;
    mapView.delegate = self;
    [UIView transitionFromView:self.view toView:mapView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
        
    }];
}

- (IBAction)showNextPlace:(id)sender {
    [mDelegate showNextPlace];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PlacePageBG"]]];
}

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
