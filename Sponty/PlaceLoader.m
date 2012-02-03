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
    //data = SOME API CALL
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
                                    [NSSet setWithObjects:@"Beer Me", @"Sit Back", @"Chill Out", nil], @"categories",
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
    NSDictionary * bowlingDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"Boardwalk Bowl", @"name",
                                  @"00000000000003", @"placeID",
                                  [NSNumber numberWithFloat:36.966095], @"lat",
                                  [NSNumber numberWithFloat:-122.018623], @"long",
                                  [NSNumber numberWithDouble:101.2], @"dist",
                                  @"It's open for another 5 hours and 35 minutes.", @"timeSuggest",
                                  @"It's getting chilly, head over to Boardwalk Bowl to grab a lane.", @"weatherSuggest",
                                  @"It's a short car ride away (101.2 miles).", @"distanceSuggest",
                                  @"http://www.greatercitrususbca.com/bowling.jpg", @"feature",
                                  [NSSet setWithObjects:@"Chill Out", @"Hang Out", nil], @"categories",
                                  @"YES", @"featured",
                                  nil];
    NSDictionary * pizzaDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"Woodstock Pizza", @"name",
                                @"00000000000004", @"placeID",
                                [NSNumber numberWithFloat:36.97177], @"lat",
                                [NSNumber numberWithFloat:-122.026584], @"long",
                                [NSNumber numberWithDouble:95.8], @"dist",
                                @"It's open for another 6 hours and 12 minutes.", @"timeSuggest",
                                @"There's nothing hot slice of pesto pizza can't solve!", @"weatherSuggest",
                                @"You could walk there, its 95.8 miles away.", @"distanceSuggest",
                                @"http://farm4.static.flickr.com/3207/2990056985_15ce173a44.jpg", @"feature",
                                [NSSet setWithObjects:@"Beer Me", @"Chill Out", nil], @"categories",
                                @"NO", @"featured",
                                nil];
    NSDictionary * pacificdict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"Pacific Street", @"name",
                                  @"00000000000005", @"placeID",
                                  [NSNumber numberWithFloat:36.97177], @"lat",
                                  [NSNumber numberWithFloat:-122.026584], @"long",
                                  [NSNumber numberWithDouble:93], @"dist",
                                  @"It's always open.", @"timeSuggest",
                                  @"Go enjoy this brisk night by walking under the lights.", @"weatherSuggest",
                                  @"It's a walkable 93 miles away.", @"distanceSuggest",
                                  @"http://santacruz.indymedia.org/usermedia/image/12/large/pacific_12-31-05.jpg", @"panorama",
                                  [NSSet setWithObjects:@"Chill Out", nil], @"categories",
                                  @"NO", @"featured",
                                  nil];
    Place * boardwalk = [[Place alloc] initWithDictionary:boardwalkDict];
    Place * coldStone = [[Place alloc] initWithDictionary:coldStoneDict];
    Place * bowling = [[Place alloc] initWithDictionary:bowlingDict];
    Place * pizza = [[Place alloc] initWithDictionary:pizzaDict];
    Place * pacific = [[Place alloc] initWithDictionary:pacificdict];
    
    return [NSArray arrayWithObjects:boardwalk, coldStone, bowling, pizza, pacific, nil];
}

@end
