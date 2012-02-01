//
//  RegistrationSelectionViewController.m
//  Sponty
//
//  Created by Peter Tsoi on 12/21/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "RegistrationSelectionViewController.h"

@implementation RegistrationSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction) selectedFacebookLogin:(id)sender {
    
}

- (IBAction) showManualLogin:(id)sender {
    self.view = login;
    [login setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgpattern.png"]]];
}

- (IBAction) processManualLogin:(id)sender {
    
}

- (IBAction) showRegistration:(id)sender {
    
}

- (IBAction) showDemographics:(id)sender {
    
}

- (IBAction) dismiss:(id)sender {
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgpattern.png"]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
