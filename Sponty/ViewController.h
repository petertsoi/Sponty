//
//  ViewController.h
//  Sponty
//
//  Created by Peter Tsoi on 11/27/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class PlaceViewController;
@class Checkbox;

@interface ViewController : UIViewController <CLLocationManagerDelegate> {
    IBOutlet UIButton * startButton;
    IBOutlet Checkbox * friendsCheckbox;
    IBOutlet Checkbox * dateCheckbox;
    UISwipeGestureRecognizer * gestureRecognizer;
    PlaceViewController * placeVC;
    
    CLLocationManager * locationManager;
    CLLocationCoordinate2D myLocation;
}

@property (nonatomic) CLLocationCoordinate2D myLocation;
@property (nonatomic, retain) CLLocationManager * locationManager;

- (IBAction) startButtonPressed:(id) sender; 
- (IBAction) showSettings:(id) sender;
- (void) swipedLeft:(id)sender;
- (void) finishedEditingSettings;
- (PlaceViewController *) getNextPlace;
- (void) switchedToNewPlace:(PlaceViewController *)newPlace;
- (void) showNextPlace;

- (IBAction) selectedFriends:(id)sender;
- (IBAction) selectedDate:(id)sender;

@end
