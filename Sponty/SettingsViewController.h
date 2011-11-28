//
//  SettingsViewController.h
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface SettingsViewController : UIViewController {
    ViewController * mDelegate;
}

@property (nonatomic, retain) UIViewController * delegate;

- (IBAction) dismissSettings:(id) sender;

@end
