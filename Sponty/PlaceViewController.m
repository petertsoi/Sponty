//
//  PlaceViewController.m
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "PlaceViewController.h"

#import "ViewController.h"

#import "Place.h"

#import "PlaceDetailView.h"
#import "PlaceMapView.h"

#import "PlaceScrollerView.h"
#import "PlaceListView.h"
#import "PlaceListViewCell.h"
#import "PlaceListHeaderView.h"

#import "PlaceLoader.h"

@implementation PlaceViewController

@synthesize delegate = mDelegate;
@synthesize pageControl = mPageControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        listFilter = -1; // ALL
        indexOfListView = 0;
        categories = [[NSMutableArray alloc] initWithObjects:@"Beer Me", @"Sit Back", @"Chill Out", nil];
        loadedPlaces = [[NSMutableArray alloc] init];
        [self.view setBackgroundColor:[UIColor clearColor]];
        
        
        loader = [[PlaceLoader alloc] init];
        places = [[loader getAllPlaces] mutableCopy];
        
        NSMutableDictionary * placesDictTmp = [[NSMutableDictionary alloc] init];
        for (NSString * category in categories) {
            NSMutableArray * catList = [[NSMutableArray alloc] init];
            for (Place * place in places ) {
                if ([place.categories containsObject:category]) {
                    [catList addObject:place];
                }
            }
            [placesDictTmp setValue:catList forKey:category];
            [catList release];
        }
        placeCategories = [[NSDictionary alloc] initWithDictionary:placesDictTmp];
        [placesDictTmp release];
        
        for (Place * currentPlace in places) {
            if (currentPlace.featured) {
                [(PlaceScrollerView* )self.view addToContents:[currentPlace getViewWithController:self] withController:self];
                [loadedPlaces addObject:currentPlace];
                indexOfListView++;
            }
        }
        featuredCount = indexOfListView;
        listView = [[[NSBundle mainBundle] loadNibNamed:@"PlaceListView" owner:self options:nil] objectAtIndex:0];
        for (NSString * newCategory in categories) {
            [listView addTab:newCategory];
        }
        
        [(PlaceScrollerView* )self.view addToContents:listView withController:self];
        [self setCurrentViewToIndex:0];
    }
    return self;
}

- (void)setCurrentViewToIndex:(int)index {
    if (index < [places count])
        currentView = [(Place * )[places objectAtIndex:index] view];
    while (index == indexOfListView && [loadedPlaces count] > indexOfListView) {
        Place * removed = [loadedPlaces lastObject];
        [loadedPlaces removeObject:removed];
        [(PlaceScrollerView* )self.view removeFromContents:removed];
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) hideMapView {
    [self.view setUserInteractionEnabled:NO];
    //[mapView setUserInteractionEnabled:NO];
    //[currentView setUserInteractionEnabled:NO];
    [UIView transitionFromView:mapView toView:currentView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
        [mapView retain];
        [self.view setUserInteractionEnabled:YES];
        
        //[currentView setUserInteractionEnabled:YES];
    }];
    
}

- (void) switchToListFilter:(int)filter {
    listFilter = filter -1;
    [listView.tableView reloadData];
}

- (IBAction)showMapView:(id)sender {
    if (mapView && [mapView retainCount] > 0) {
        [mapView release];
    }
    
    mapView = [[[[NSBundle mainBundle] loadNibNamed:@"PlaceMapView" owner:self options:nil] objectAtIndex:0] retain];
    mapView.delegate = self;
    //[self.view setUserInteractionEnabled:NO];
    //[currentView setUserInteractionEnabled:NO];
    //[mapView setUserInteractionEnabled:NO];
    [UIView transitionFromView:currentView toView:mapView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
        [mapView roundCorners];
        [mapView setLatLong:currentView.place.latLong];
        //[self.view setUserInteractionEnabled:YES];
        //[mapView setUserInteractionEnabled:YES];
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

    Place * thisPlace;
    if (listFilter < 0) {
        thisPlace = [[placeCategories objectForKey:[categories objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    } else {
        thisPlace = [[placeCategories objectForKey:[categories objectAtIndex:listFilter]] objectAtIndex:indexPath.row];
    }
    
    cell.placeNameLabel.text = thisPlace.name;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.1f miles away", [thisPlace.distanceAway doubleValue]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Place * thisPlace;
    if (listFilter < 0) {
        thisPlace = [[placeCategories objectForKey:[categories objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    } else {
        thisPlace = [[placeCategories objectForKey:[categories objectAtIndex:listFilter]] objectAtIndex:indexPath.row];
    }
    
    if ([loadedPlaces containsObject:thisPlace]){
        int viewIndex = [loadedPlaces indexOfObject:thisPlace];
        if (viewIndex >= indexOfListView)
            viewIndex++;
        [(PlaceScrollerView* )self.view scrollTo:viewIndex];
    } else {
        [(PlaceScrollerView* )self.view addToContents:[thisPlace getViewWithController:self] withController:self];
        [loadedPlaces addObject:thisPlace];
        int viewIndex = [loadedPlaces indexOfObject:thisPlace] + 1;
        [(PlaceScrollerView* )self.view scrollTo:viewIndex];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (listFilter == -1)
        return [categories count];
    else
        return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section < [categories count]) {
        if (listFilter == -1) {
            return [categories objectAtIndex:section];
        }  else {
            return [categories objectAtIndex:listFilter];
        }
    } else {
        return @"Other";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PlaceListHeaderView *titleLabel = [[PlaceListHeaderView alloc] init];
    [titleLabel setFont:[UIFont fontWithName:@"nevis" size:14.0f]];
    [titleLabel setBackgroundColor:[UIColor whiteColor]];
    [titleLabel setTextColor:[UIColor colorWithRed:0.255 green:0.247 blue:0.224 alpha:1.0]];
    [titleLabel setText:[self tableView:tableView titleForHeaderInSection:section]];
    return (UILabel *)titleLabel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    if (listFilter < 0) 
        return [[placeCategories objectForKey:[categories objectAtIndex:section]] count];
    else
        return [[placeCategories objectForKey:[categories objectAtIndex:listFilter]] count];

}
/*
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
    [self.view insertSubview:newDetailView belowSubview:currentView];
    
    [UIView transitionFromView:detailView toView:currentView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished){
        [detailView release];
        detailView = newDetailView;
    }];
}
*/
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
