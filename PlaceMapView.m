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
    //pacific st. 36.97177,-122.026584&fspn=0.00984,0.013497
    //fentons 37.827819,-122.250345&fspn=0.011966,0.016007
    zoomLocation.latitude = 36.97177;
    zoomLocation.longitude = -122.026584;
    MKCoordinateRegion region = MKCoordinateRegionMake(zoomLocation, MKCoordinateSpanMake(0.00984,0.013497));
    [mMapView setRegion:region animated:YES];
    
    MKPlacemark * dest = [[MKPlacemark alloc] initWithCoordinate:zoomLocation addressDictionary:nil];
    
    [mMapView addAnnotation:dest];
}

- (IBAction) hideMapView:(id)sender {
    [mDelegate hideMapView];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    if(pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.animatesDrop = YES;
    } else {
        pinView.annotation = annotation;
    }
    return pinView;
}
                                  
                                  

@end
