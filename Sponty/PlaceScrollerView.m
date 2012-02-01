//
//  PlaceScrollerView.m
//  Sponty
//
//  Created by Peter Tsoi on 1/6/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#ifndef SCRUB_RESOLUTION 
#define SCRUB_RESOLUTION 20
#endif

#import "PlaceScrollerView.h"

#import "PlaceViewController.h"

@implementation PlaceScrollerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        numberLoaded = 0;
        currentSelection = 0;
        contents = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, 
                                                            self.frame.size.width*2, self.frame.size.height)];
        [self addSubview:contents];
    }
    return  self;
}

- (void)scrollLeft:(id)selector{
    NSLog(@"Scrolling left");
    [self setUserInteractionEnabled:NO];
    [UIView beginAnimations:@"scrollLeft" context:NULL];
    if (selector == self){
        [UIView setAnimationDuration:0.25f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    } else {
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    }
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(scrollFinished)];
    
    currentSelection++;
    contents.frame = CGRectMake(0 - (currentSelection * self.frame.size.width), contents.frame.origin.y, 
                                contents.frame.size.width, contents.frame.size.height);
    
    [UIView commitAnimations];
}

- (void)scrollRight:(id)selector{
    NSLog(@"Scrolling right");
    [self setUserInteractionEnabled:NO];
    [UIView beginAnimations:@"scrollRight" context:NULL];
    if (selector == self){
        [UIView setAnimationDuration:0.25f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    } else {
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    }
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(scrollFinished)];
    
    currentSelection--;
    
    contents.frame = CGRectMake(0 - (currentSelection * self.frame.size.width), contents.frame.origin.y, 
                                contents.frame.size.width, contents.frame.size.height);
    
    [UIView commitAnimations];
}

- (void)snapMiddle{
    [UIView beginAnimations:@"snapToMiddle" context:NULL];
    [UIView setAnimationDuration:0.25f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    
    
    contents.frame = CGRectMake(0 - (currentSelection * self.frame.size.width), contents.frame.origin.y, 
                                contents.frame.size.width, contents.frame.size.height);
    
    [UIView commitAnimations];
}


- (void)scrollFinished{
    UIPageControl * pager = delagate.pageControl;
    [pager  setCurrentPage:currentSelection];
    [self setUserInteractionEnabled:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * aTouch = [touches anyObject];
    touchStartLocation = [aTouch locationInView:self];
    lastRecordedLocation = touchStartLocation;
    NSLog(@"Touch began");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint currentTouchLocation = [[touches anyObject] locationInView:self];
    if (fabsf(currentTouchLocation.x - lastRecordedLocation.x) < SCRUB_RESOLUTION) {
        
        contents.frame = CGRectMake(0 - (currentSelection * self.frame.size.width) + currentTouchLocation.x - touchStartLocation.x, contents.frame.origin.y, 
                                contents.frame.size.width, contents.frame.size.height);
        lastRecordedLocation = currentTouchLocation;
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)[[touches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView:self];
    if (location.x - touchStartLocation.x < -100 && currentSelection + 1 < numberLoaded) {
        NSLog(@"%i, %i", currentSelection, numberLoaded);
        NSLog(@"Going left");
        [self scrollLeft:self];
    } else if (location.y - touchStartLocation.x > 100 && currentSelection > 0){
        NSLog(@"Going right");
        [self scrollRight:self];
    } else {
        [self snapMiddle];
    }
}

- (void) addToContents:(UIView *)view withController:(PlaceViewController *) ctrl {
    delagate = ctrl;
    float newXVal = numberLoaded * self.frame.size.width;
    [view setFrame:CGRectMake(view.frame.origin.x + newXVal, view.frame.origin.y, 
                              view.frame.size.width, view.frame.size.height)];
    [contents addSubview:view];
    numberLoaded++;
    [delagate.pageControl setNumberOfPages:numberLoaded];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
