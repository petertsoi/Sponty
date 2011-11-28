//
//  ViewController.h
//  Sponty
//
//  Created by Peter Tsoi on 11/27/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaceViewController;

@interface ViewController : UIViewController {
    IBOutlet UIButton * startButton;
    PlaceViewController * placeVC;
}

- (IBAction) startButtonPressed:(id) sender; 
- (IBAction) showSettings:(id) sender;
- (void) finishedEditingSettings;
- (PlaceViewController *) getNextPlace;
- (void) switchedToNewPlace:(PlaceViewController *)newPlace;
- (void) showNextPlace;

@end
