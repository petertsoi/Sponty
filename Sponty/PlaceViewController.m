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

#import "PlaceScrollerView.h"
#import "PlaceListView.h"
#import "PlaceListViewCell.h"
#import "PlaceListHeaderView.h"

@implementation PlaceViewController

@synthesize delegate = mDelegate;
@synthesize pageControl = mPageControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor clearColor]];
        counter = 0;
        // Custom initialization
        detailView = [[[NSBundle mainBundle] loadNibNamed:@"PlaceDetailView" owner:self options:nil] objectAtIndex:0];
        [detailView retain];
        
        [detailView setPlaceName:@"Santa Cruz Boardwalk"];
        [detailView setFeatureImage:[UIImage imageNamed:@"boardwalk"]];
        [detailView setTimeSuggest:@"It's always open."];
        [detailView setWeatherSuggest:@"It's a gorgeous 68º now. Go enjoy a walk on the boardwalk."];
        [detailView setDistanceSuggest:@"Best of all, its only 0.2 miles away!"];
        
        [(PlaceScrollerView* )self.view addToContents:detailView withController:self];
        
        nextPreloaded = [[[NSBundle mainBundle] loadNibNamed:@"PlaceDetailView" owner:self options:nil] objectAtIndex:0];
        
        [nextPreloaded setPlaceName:@"Santa Cruz Scoop"];
        //[newDetailView setFeatureImage:[UIImage imageNamed:@"icecream"]];
        [nextPreloaded setPanoramaURL:@"http://photosynth.net/view.aspx?cid=fab244bc-86f9-413e-ad41-bed9fda5c701"];
        [nextPreloaded setTimeSuggest:@"It's open for another 6 hours and 12 minutes."];
        [nextPreloaded setWeatherSuggest:@"On a chilly day like this, hot fudge is the way to go."];
        [nextPreloaded setDistanceSuggest:@"It's a walkable 0.1 miles away."];
        [nextPreloaded retain];
        
        [(PlaceScrollerView* )self.view addToContents:nextPreloaded withController:self];
        //[self.view addSubview:[[MocapOverlayView alloc] initWithSuperView:self.view]];
        
        listView = [[[NSBundle mainBundle] loadNibNamed:@"PlaceListView" owner:self options:nil] objectAtIndex:0];
        [(PlaceScrollerView* )self.view addToContents:listView withController:self];
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
    [self.view setUserInteractionEnabled:NO];
    [mapView setUserInteractionEnabled:NO];
    [detailView setUserInteractionEnabled:NO];
    [UIView transitionFromView:mapView toView:detailView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
        [self.view setUserInteractionEnabled:YES];
        [detailView setUserInteractionEnabled:YES];
    }];
    
}

- (IBAction)showMapView:(id)sender {
    mapView = [[[NSBundle mainBundle] loadNibNamed:@"PlaceMapView" owner:self options:nil] objectAtIndex:0];
    mapView.delegate = self;
    [self.view setUserInteractionEnabled:NO];
    [detailView setUserInteractionEnabled:NO];
    [mapView setUserInteractionEnabled:NO];
    [UIView transitionFromView:detailView toView:mapView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
        [mapView roundCorners];
        [self.view setUserInteractionEnabled:YES];
        [mapView setUserInteractionEnabled:YES];
    }];
    //[self.view addSubview:[[MocapOverlayView alloc] initWithSuperView:self.view]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlaceCell";
    
    PlaceListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PlaceListViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    cell.placeNameLabel.text = @"Fenton's Ice Cream";
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %i", section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PlaceListHeaderView *titleLabel = [[PlaceListHeaderView alloc] initWithFrame:CGRectMake(0, 0, 
                                                                                            tableView.frame.size.width, 22)];
    [titleLabel setFont:[UIFont fontWithName:@"nevis" size:14.0f]];
    [titleLabel setBackgroundColor:[UIColor whiteColor]];
    [titleLabel setTextColor:[UIColor colorWithRed:0.255 green:0.247 blue:0.224 alpha:1.0]];
    [titleLabel setText:[self tableView:tableView titleForHeaderInSection:section]];
    return (UILabel *)titleLabel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return 5;
}

- (IBAction)showNextPlace:(id)sender {
    ++counter;
    PlaceDetailView * newDetailView = [[[NSBundle mainBundle] loadNibNamed:@"PlaceDetailView" owner:self options:nil] objectAtIndex:0];
    [newDetailView retain];
    
    switch (counter) {
        case 1:
            newDetailView = nextPreloaded;
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
    [self.view insertSubview:newDetailView belowSubview:detailView];
    
    [UIView transitionFromView:detailView toView:detailView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished){
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
