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
@synthesize locationManager;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    myLocation = newLocation.coordinate;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

- (void) awakeFromNib {
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.delegate = self; // send loc updates to myself
    [locationManager startUpdatingLocation];
}

- (void) setLatLong:(CLLocationCoordinate2D)loc {
    //pacific st. 36.97177,-122.026584&fspn=0.00984,0.013497
    //fentons 37.827819,-122.250345&fspn=0.011966,0.016007
    
    MKCoordinateRegion region = MKCoordinateRegionMake(loc, MKCoordinateSpanMake(0.00984,0.013497));
    [mMapView setRegion:region animated:YES];
    
    MKPlacemark * dest = [[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil];
    
    placeLocation = loc;
    
    [mMapView addAnnotation:dest];

}

- (void) roundCorners {
    mMapView.layer.cornerRadius = 10.0;
    mMapView.layer.masksToBounds = YES;
}

- (IBAction) hideMapView:(id)sender {
    [mDelegate hideMapView];
}

- (IBAction) getDirections:(id)sender {
    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%f,%f&saddr=%f,%f", placeLocation.latitude, placeLocation.longitude, myLocation.latitude, myLocation.longitude]]];
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

- (void) dealloc {
    [locationManager release];
    [super dealloc];
}
                                  
                                  

@end
