//
//  PlaceMapView.h
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@class PlaceViewController;

@interface PlaceMapView : UIView <MKMapViewDelegate, CLLocationManagerDelegate> {
    PlaceViewController * mDelegate;
    IBOutlet MKMapView * mMapView;
    
    CLLocationCoordinate2D placeLocation;
    CLLocationCoordinate2D myLocation;
}

@property (nonatomic, retain) PlaceViewController * delegate;

- (void) roundCorners;
- (void) setLatLong:(CLLocationCoordinate2D)loc;
- (IBAction)getDirections:(id)sender;

@end
