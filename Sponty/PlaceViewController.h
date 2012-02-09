//
//  PlaceViewController.h
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class PlaceMapView;
@class PlaceDetailView;
@class PlaceScrollerView;
@class PlaceListView;
@class PlaceLoader;

@interface PlaceViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    ViewController * mDelegate;
    PlaceMapView * mapView;
    PlaceDetailView * currentView;
    PlaceListView * listView;
    PlaceLoader * loader;
    
    NSDictionary * placeCategories;
    
    NSMutableArray * places;
    NSMutableArray * categories;
    
    NSMutableArray * loadedPlaces;
    
    int listFilter;
    int indexOfListView;
    int featuredCount;
    
    IBOutlet UIPageControl * mPageControl;
}
@property (nonatomic, strong) ViewController * delegate;
@property (nonatomic, strong) UIPageControl * pageControl;

- (IBAction)showMapView:(id)sender;
- (void)hideMapView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withController:(ViewController *)controller;
- (void)setCurrentViewToIndex:(int)index;

- (void) switchToListFilter:(int)filter;
//- (IBAction)showNextPlace:(id)sender;

@end
