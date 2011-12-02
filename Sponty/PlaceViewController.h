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

@interface PlaceViewController : UIViewController {
    ViewController * mDelegate;
    PlaceMapView * mapView;
    PlaceDetailView * detailView;
    
    int counter; // temp for demo
}
@property (nonatomic, strong) ViewController * delegate;

- (IBAction)showMapView:(id)sender;
- (void)hideMapView;
- (IBAction)showNextPlace:(id)sender;

@end
