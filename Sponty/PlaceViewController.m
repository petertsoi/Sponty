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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withController:(ViewController *)controller
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mDelegate = controller;
        listFilter = -1; // ALL
        indexOfListView = 0;
        categories = [[NSMutableArray alloc] initWithObjects:@"party", @"relax", @"eat", @"active", nil];
        loadedPlaces = [[NSMutableArray alloc] init];
        [self.view setBackgroundColor:[UIColor clearColor]];
        
        
        loader = [[PlaceLoader alloc] initWithController:self];
        places = [[loader getAllPlaces] mutableCopy];
        
        NSMutableDictionary * placesDictTmp = [[NSMutableDictionary alloc] init];
        for (Place * place in places ) {
            bool hasCategory = NO;
            for (NSString * category in categories) {
                NSMutableArray * catList = [placesDictTmp objectForKey:category];
                if (!catList)
                    catList = [[NSMutableArray alloc] init];
                if ([place.categories containsObject:category]) {
                    [catList addObject:place];
                    hasCategory = YES;
                }
                [placesDictTmp setValue:catList forKey:category];
            }
            if (!hasCategory) {
                NSMutableArray * otherList = [placesDictTmp objectForKey:@"other"];
                if (!otherList) {
                    otherList = [[NSMutableArray alloc] init];
                }
                [otherList addObject:place];
                [placesDictTmp setValue:otherList forKey:@"other"];
            }
            
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
    if (index == indexOfListView) {
        [TestFlight passCheckpoint:@"Reached list view"];
    }
    if (index < [loadedPlaces count]) {
        currentView = [(Place * )[loadedPlaces objectAtIndex:index] view];
    }
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
    [TestFlight passCheckpoint:@"Hiding Map."];
    [self.view setUserInteractionEnabled:NO];
    [UIView transitionFromView:mapView toView:currentView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
        [mapView retain];
        [self.view setUserInteractionEnabled:YES];
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
    [TestFlight passCheckpoint:@"Launching Map."];
    mapView = [[[[NSBundle mainBundle] loadNibNamed:@"PlaceMapView" owner:self options:nil] objectAtIndex:0] retain];
    mapView.delegate = self;
    [UIView transitionFromView:currentView toView:mapView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
        [mapView roundCorners];
        [mapView setLatLong:currentView.place.latLong];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlaceCell";
    
    PlaceListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PlaceListViewCell" owner:self options:nil] objectAtIndex:0];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0) {
            [cell.placeNameLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
            [cell.distanceLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
        }
    }

    Place * thisPlace;
    if (listFilter < 0) {
        if (indexPath.section == [categories count]) 
            thisPlace = [[placeCategories objectForKey:@"other"] objectAtIndex:indexPath.row];
        else
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
        if (indexPath.section == [categories count]) 
            thisPlace = [[placeCategories objectForKey:@"other"] objectAtIndex:indexPath.row];
        else
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
    [TestFlight passCheckpoint:@"Selected location from list."];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (listFilter == -1) {
        if (![placeCategories objectForKey:@"other"])
            return [categories count];
        else
            return [categories count] + 1;
    } else
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
        return @"other";
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
    if (listFilter < 0) {
        if (section == [categories count])
            return [[placeCategories objectForKey:@"other"] count];
        else
            return [[placeCategories objectForKey:[categories objectAtIndex:section]] count];
    } else
        return [[placeCategories objectForKey:[categories objectAtIndex:listFilter]] count];

}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
