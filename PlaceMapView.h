//
//  PlaceMapView.h
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaceViewController;

@interface PlaceMapView : UIView {
    PlaceViewController * mDelegate;
}

@property (nonatomic, retain) PlaceViewController * delegate;

@end
