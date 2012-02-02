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

@interface PlaceViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    ViewController * mDelegate;
    PlaceMapView * mapView;
    PlaceDetailView * detailView;
    PlaceDetailView * nextPreloaded;
    PlaceListView * listView;
    
    IBOutlet UIPageControl * mPageControl;
    
    int counter; // temp for demo
}
@property (nonatomic, strong) ViewController * delegate;
@property (nonatomic, strong) UIPageControl * pageControl;

- (IBAction)showMapView:(id)sender;
- (void)hideMapView;
- (IBAction)showNextPlace:(id)sender;

@end
