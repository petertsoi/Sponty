//
//  ViewController.h
//  Sponty
//
//  Created by Peter Tsoi on 11/27/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UIButton * startButton;
}

- (IBAction) startButtonPressed:(id) sender; 
- (IBAction) showSettings:(id) sender;
- (void) finishedEditingSettings;

@end
