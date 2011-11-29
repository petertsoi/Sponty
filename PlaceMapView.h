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

@class PlaceViewController;

@interface PlaceMapView : UIView {
    PlaceViewController * mDelegate;
    IBOutlet MKMapView * mMapView;
}

@property (nonatomic, retain) PlaceViewController * delegate;

- (void) roundCorners;

@end
