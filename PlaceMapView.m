//
//  PlaceMapView.m
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "PlaceMapView.h"

#import "PlaceViewController.h"

@implementation PlaceMapView

@synthesize delegate = mDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"Creating map view");
        UIButton * hideButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [hideButton setFrame:CGRectMake(50, 40, 220, 30)];
        [hideButton setTitle:@"Hello" forState:UIControlStateNormal];
        [hideButton addTarget:self action:@selector(hideMapView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hideButton];
    }
    return self;
} 

- (void) hideMapView {
    NSLog(@"Other hide");
    [mDelegate hideMapView];
}

@end
