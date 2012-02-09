//
//  PlaceLoader.h
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlaceDetailView;
@class PlaceViewController;
@class Place;

@interface PlaceLoader : NSObject {
    PlaceViewController * mDelegate;
}

- (id) initWithController:(PlaceViewController * )control;

- (Place *) getNextPlace;
- (NSArray *) getAllPlaces;

@end
