//
//  PlaceLoader.m
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "PlaceLoader.h"

#import "SBJson.h"

#import "Place.h"
#import "PlaceViewController.h"
#import "ViewController.h"
#import "PlaceDetailView.h"

@implementation PlaceLoader

- (id) initWithController:(PlaceViewController *)control {
    self = [super init];
    if (self) {
        mDelegate = control;
    }
    return self;
}

- (Place *) getNextPlace {
    return nil;
}

- (NSArray *) getAllPlaces {
    CLLocationCoordinate2D coord =  [mDelegate.delegate getLocation];
    NSString * query = [NSString stringWithFormat:@"http://sponty.palash.me:8004/recommend?time=%0.f&location=%f,%f&who=myself", [[NSDate date] timeIntervalSince1970], coord.latitude, coord.longitude];
    //NSLog(@"%@", query);
    NSURL  *url = [NSURL URLWithString:query];
    
    NSData * jsonData = [NSData dataWithContentsOfURL:url];
    
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSArray * places = [parser objectWithData:jsonData];
    
    NSMutableArray * toReturn = [[NSMutableArray alloc] init];
    
    for (NSDictionary * newPlace in places) {
        //NSLog(@"Name: %@", [newPlace objectForKey:@"name"]);
        //NSLog(@"Location: %f, %f", [[[newPlace objectForKey:@"location"] objectAtIndex:0] floatValue], [[[newPlace objectForKey:@"location"] objectAtIndex:1] floatValue]);
        NSDictionary * tips = [newPlace objectForKey:@"tips"];
        
        NSString *featuredString = @"NO";
        if ([[newPlace objectForKey:@"featured"] boolValue]) {
            featuredString = @"YES";
        }
        
        //NSLog(@"Activity: %@", [tips objectForKey:@"activity"]);
        //NSLog(@"Popularity: %@", [tips objectForKey:@"popularity"]);
        //NSLog(@"Distance: %@", [tips objectForKey:@"distance"]);
        NSDictionary * formattedDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [newPlace objectForKey:@"name"], @"name",
                                        [[newPlace objectForKey:@"location"] objectAtIndex:0], @"long",
                                        [[newPlace objectForKey:@"location"] objectAtIndex:1], @"lat",
                                        [newPlace objectForKey:@"distance"], @"dist",
                                        [tips objectForKey:@"activity"], @"timeSuggest",
                                        [tips objectForKey:@"popularity"], @"weatherSuggest",
                                        [tips objectForKey:@"distance"], @"distanceSuggest",
                                        [NSSet setWithObject:[newPlace objectForKey:@"category"]], @"categories",
                                        featuredString, @"featured",
                                        [newPlace objectForKey:@"picture"], @"feature",
                                        nil];
        [toReturn addObject:[[Place alloc] initWithDictionary:formattedDict]];
    }
    
    return toReturn;
}

@end
