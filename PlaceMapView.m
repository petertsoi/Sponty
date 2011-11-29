//
//  PlaceMapView.m
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "PlaceMapView.h"

#import "PlaceViewController.h"

@implementation PlaceMapView

@synthesize delegate = mDelegate;

- (void) roundCorners {
    mMapView.layer.cornerRadius = 10.0;
    mMapView.layer.masksToBounds = YES;
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 37.827819;
    zoomLocation.longitude = -122.250345;
    MKCoordinateRegion region = MKCoordinateRegionMake(zoomLocation, MKCoordinateSpanMake(0.011966,0.016007));
    [mMapView setRegion:region animated:YES];
}

- (IBAction) hideMapView:(id)sender {
    [mDelegate hideMapView];
}

@end
