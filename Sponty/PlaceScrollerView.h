//
//  PlaceScrollerView.h
//  Sponty
//
//  Created by Peter Tsoi on 1/6/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaceViewController;
@class Place;

@interface PlaceScrollerView : UIView {
    PlaceViewController * delagate;
    
    CGPoint touchStartLocation;
    CGPoint lastRecordedLocation;
    
    UIView * contents;
    
    NSMutableArray * modules;
    
    int numberLoaded;
    int currentSelection;
}
- (void) addToContents:(UIView *)view withController:(PlaceViewController *) ctrl;
- (void) removeFromContents:(Place *)remove;
- (void) scrollTo:(int)target;

@end
