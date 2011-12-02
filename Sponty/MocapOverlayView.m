//
//  MocapOverlayView.m
//  Sponty
//
//  Created by Peter Tsoi on 12/1/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "MocapOverlayView.h"

@implementation MocapOverlayView
#ifdef __MOCAP
- (id)initWithSuperView:(UIView *)superview
{
    CGRect frame = superview.frame;
    mSuperView = superview;
    //self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y-18, frame.size.width, frame.size.height + 18)];
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mocaptrackscreen.png"]]];
        [self setAlpha:0.9f];
    }
    return self;
}
#else
- (id)initWithSuperView:(UIView *)superview
{
    CGRect frame = superview.frame;
    mSuperView = superview;
    //self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y-18, frame.size.width, frame.size.height + 18)];
    self = [super initWithFrame:frame];
    if (self) {
        // default setup
    }
    return self;
}
#endif

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    [self removeFromSuperview];
    UIView * hit = [mSuperView hitTest:point withEvent:event];
    [mSuperView addSubview:self];
    return hit;
}

@end
