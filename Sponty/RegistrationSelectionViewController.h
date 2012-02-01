//
//  RegistrationSelectionViewController.h
//  Sponty
//
//  Created by Peter Tsoi on 12/21/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RegistrationSelectionViewController : UIViewController {
    IBOutlet UIView * selection;
    IBOutlet UIView * login;
    IBOutlet UIView * registration;
    IBOutlet UIView * demographics;
}

- (IBAction) selectedFacebookLogin:(id)sender;
- (IBAction) showManualLogin:(id)sender;
- (IBAction) processManualLogin:(id)sender;
- (IBAction) showRegistration:(id)sender;
- (IBAction) showDemographics:(id)sender;
- (IBAction) dismiss:(id)sender;

@end
