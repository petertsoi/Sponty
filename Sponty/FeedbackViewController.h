//
//  FeedbackViewController.h
//  Sponty
//
//  Created by Peter Tsoi on 2/15/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface FeedbackViewController : UIViewController {
    IBOutlet UITextField * name;
    IBOutlet UITextView * feedback;
    
    NSMutableData * responseData;
    
    ViewController * mDelegate;
}

@property (nonatomic, retain) UIViewController * delegate;

- (IBAction) dismissSettings:(id) sender;
- (IBAction) sendFeedback:(id)sender;

@end
