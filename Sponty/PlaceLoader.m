//
//  PlaceLoader.m
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "PlaceLoader.h"

#import "Place.h"
#import "PlaceDetailView.h"

@implementation PlaceLoader

- (Place *) getNextPlace {
    return nil;
}

- (NSArray *) getAllPlaces {
    /* PCT: Replace this code with the API call. This stuff is hard coded */
    NSDictionary * boardwalkDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Santa Cruz Boardwalk", @"name",
                                    @"00000000000001", @"placeID",
                                    [NSNumber numberWithFloat:36.966095], @"lat",
                                    [NSNumber numberWithFloat:-122.018623], @"long",
                                    [NSNumber numberWithDouble:100], @"dist",
                                    @"It's always open.", @"timeSuggest",
                                    @"It's a gorgeous 68º now. Go enjoy a walk on the boardwalk.", @"weatherSuggest",
                                    @"Best of all, its only 100 miles away!", @"distanceSuggest",
                                    @"http://www.planetware.com/i/photo/santa-cruz-beach-boardwalk-santa-cruz-cascruz.jpg", @"feature",
                                    [NSSet setWithObjects:@"Beer Me", @"Chill Out", @"Sit Back", nil], @"categories",
                                    @"YES", @"featured",
                                    nil];
    NSDictionary * coldStoneDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Cold Stone", @"name",
                                    @"00000000000002", @"placeID",
                                    [NSNumber numberWithFloat:36.97177], @"lat",
                                    [NSNumber numberWithFloat:-122.026584], @"long",
                                    [NSNumber numberWithDouble:93], @"dist",
                                    @"It's open for another 6 hours and 12 minutes.", @"timeSuggest",
                                    @"On a chilly day like this, hot fudge is the way to go.", @"weatherSuggest",
                                    @"It's a walkable 93 miles away.", @"distanceSuggest",
                                    @"http://photosynth.net/view.aspx?cid=fab244bc-86f9-413e-ad41-bed9fda5c701", @"panorama",
                                    [NSSet setWithObjects:@"Chill Out", nil], @"categories",
                                    @"YES", @"featured",
                                    nil];
    Place * boardwalk = [[Place alloc] initWithDictionary:boardwalkDict];
    Place * coldStone = [[Place alloc] initWithDictionary:coldStoneDict];
    
    return [NSArray arrayWithObjects:boardwalk, coldStone, nil];
}

@end
