//
//  Place.m
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "Place.h"

#import "PlaceDetailView.h"

@implementation Place

@synthesize name;
@synthesize distanceAway;
@synthesize featured;
@synthesize view = mView;
@synthesize categories;
@synthesize latLong = gpsLoc;

- (id) initWithDictionary:(NSDictionary *) data {
    self = [super init];
    if (self) {
        placeID = [data objectForKey:@"placeID"];
        name = [data objectForKey:@"name"];
        gpsLoc.latitude = [[data objectForKey:@"lat"] floatValue];
        gpsLoc.longitude = [[data objectForKey:@"long"] floatValue];
        distanceAway = [[data objectForKey:@"dist"] retain];
        distanceSuggest = [data objectForKey:@"distanceSuggest"];
        timeSuggest = [data objectForKey:@"timeSuggest"];
        weatherSuggest = [data objectForKey:@"weatherSuggest"];
        featureURL = [data objectForKey:@"panorama"];
        categories = [[data objectForKey:@"categories"] retain];
        featured = [[data objectForKey:@"featured"] boolValue];
        if (featureURL) {
            hasPanorama = YES;
        } else {
            hasPanorama = NO;
            featureURL = [data objectForKey:@"feature"];
        }
    }
    return self;
}

- (PlaceDetailView *) getViewWithController:(UIViewController *)controller {
    delegate = controller;
    if (!mView) {
    PlaceDetailView * view = [[[NSBundle mainBundle] loadNibNamed:@"PlaceDetailView" owner:controller options:nil] objectAtIndex:0];
    
        [view setPlace:self];
    [view setPlaceName:name];
    if (hasPanorama) {
        [view setPanoramaURL:featureURL];
    } else {
        [view setFeatureImage:featureURL];
    }
    [view setTimeSuggest:timeSuggest];
    [view setWeatherSuggest:weatherSuggest];
    [view setDistanceSuggest:distanceSuggest];
    
    mView = view;
    }

    return mView;
}

@end
