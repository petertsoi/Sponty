//
//  Place.h
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class PlaceDetailView;

@interface Place : NSObject {
    NSString * name;
    NSString * placeID;
    CLLocationCoordinate2D gpsLoc;
    NSNumber * distanceAway;
    
    bool hasPanorama;
    NSString * featureURL;
    
    bool featured;
    
    NSString * distanceSuggest;
    NSString * timeSuggest;
    NSString * weatherSuggest;
    
    PlaceDetailView * mView;
    UIViewController *delegate;
    
    NSSet * categories;
}
@property (nonatomic,readonly,retain) NSString * name;
@property (nonatomic,readonly,retain) NSSet * categories;
@property (nonatomic,readonly,retain) NSNumber * distanceAway;
@property (nonatomic,readonly) bool featured;
@property (nonatomic,readonly) CLLocationCoordinate2D latLong;

- (id) initWithDictionary:(NSDictionary *) data;
- (PlaceDetailView *) getViewWithController:(UIViewController *)controller;

@property (nonatomic, retain) PlaceDetailView * view;

@end
