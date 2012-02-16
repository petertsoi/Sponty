//
//  FeedbackViewController.m
//  Sponty
//
//  Created by Peter Tsoi on 2/15/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "FeedbackViewController.h"

#import "ViewController.h"

@implementation FeedbackViewController

@synthesize delegate = mDelegate;

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

- (IBAction) dismissSettings:(id) sender {
    [mDelegate dismissModalViewControllerAnimated:YES];
}

- (IBAction) sendFeedback:(id)sender {
    responseData = [[NSMutableData data] retain];
    
    NSMutableURLRequest *request = [NSMutableURLRequest 
									requestWithURL:[NSURL URLWithString:@"http://sponty.palash.me:8004/feedback"]];
    
    NSString * nameStr;
    if (name.text == @"") {
        nameStr = @"[empty]";
    } else {
        nameStr = name.text;
    }
    NSString * data;
    if (feedback.text == @"") {
        data = @"[empty]";
    } else {
        data = feedback.text;
    }
    NSString *params = [[NSString alloc] initWithFormat:@"name=%@&data=%@", nameStr, data];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [mDelegate dismissModalViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([feedback isFirstResponder] && [touch view] != feedback) {
        [feedback resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgpattern.png"]]];
    
    [feedback setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"feedbackBoxBG.png"]]];
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
