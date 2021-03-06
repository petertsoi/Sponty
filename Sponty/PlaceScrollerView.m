//
//  PlaceScrollerView.m
//  Sponty
//
//  Created by Peter Tsoi on 1/6/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "PlaceScrollerView.h"

#import "Place.h"
#import "PlaceDetailView.h"
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
        modules = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return  self;
}

- (void)scrollLeft:(id)selector{
    [self scrollTo:++currentSelection];
}

- (void)scrollRight:(id)selector{
    [self scrollTo:--currentSelection];
}

- (void) scrollTo:(int)target {
    [self setUserInteractionEnabled:NO];
    [self setBackgroundColor:[UIColor blackColor]];
    [UIView beginAnimations:@"scrollRight" context:NULL];
    [UIView setAnimationDuration:0.25f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(scrollFinished)];
    
    currentSelection = target;
    /*
     contents.frame = CGRectMake(0 - (currentSelection * self.frame.size.width), contents.frame.origin.y, 
     contents.frame.size.width, contents.frame.size.height);
     */
    int i = 0;
    for (UIView *currentModule in modules) {
        currentModule.frame = CGRectMake((self.frame.size.width - currentModule.frame.size.width)/2 + (i * self.frame.size.width) - (currentSelection * self.frame.size.width), currentModule.frame.origin.y, currentModule.frame.size.width, currentModule.frame.size.height);
        ++i;
    }
    [UIView commitAnimations];
}



- (void)snapMiddleWithDelay:(NSTimeInterval) delay{
    [UIView beginAnimations:@"snapToMiddle" context:NULL];
    [UIView setAnimationDelay:delay];
    [UIView setAnimationDuration:0.25f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    
    int i = 0;
    for (UIView *currentModule in modules) {
        currentModule.frame = CGRectMake((self.frame.size.width - currentModule.frame.size.width)/2 + (i * self.frame.size.width) - (currentSelection * self.frame.size.width), currentModule.frame.origin.y, currentModule.frame.size.width, currentModule.frame.size.height);
        ++i;
    }
    [UIView commitAnimations];
}

- (void) snapMiddle {
    [self snapMiddleWithDelay:0];
}


- (void)scrollFinished{
    UIPageControl * pager = delagate.pageControl;
    [pager setCurrentPage:currentSelection];
    [self setUserInteractionEnabled:YES];
    [delagate setCurrentViewToIndex:currentSelection];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * aTouch = [touches anyObject];
    touchStartLocation = [aTouch locationInView:self];
    lastRecordedLocation = touchStartLocation;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint currentTouchLocation = [[touches anyObject] locationInView:self];
    //if (fabsf(currentTouchLocation.x - lastRecordedLocation.x) < SCRUB_RESOLUTION) {
        /*
        contents.frame = CGRectMake(0 - (currentSelection * self.frame.size.width) + currentTouchLocation.x - touchStartLocation.x, contents.frame.origin.y, 
                                contents.frame.size.width, contents.frame.size.height);
         */
        int i = 0;
        for (UIView *currentModule in modules) {
            currentModule.frame = CGRectMake(10 + (i * self.frame.size.width) - (currentSelection * self.frame.size.width) + currentTouchLocation.x - touchStartLocation.x, currentModule.frame.origin.y, currentModule.frame.size.width, currentModule.frame.size.height);
            ++i;
        }
        lastRecordedLocation = currentTouchLocation;
    //}
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)[[touches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView:self];
    if (location.x - touchStartLocation.x < -100 && currentSelection != numberLoaded - 1) {
        [self scrollLeft:self];
    } else if (location.x - touchStartLocation.x > 100){
        if (currentSelection == 0) {
            [delagate.navigationController popViewControllerAnimated:YES];
            [self snapMiddleWithDelay:0.25];
        }
        else if (currentSelection > 0) 
            [self scrollRight:self];
    } else {
        [self snapMiddle];
    }
}

- (void) drawRect:(CGRect)rect {
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void) addToContents:(UIView *)view withController:(PlaceViewController *) ctrl {
    delagate = ctrl;
    float newXVal = numberLoaded * self.frame.size.width;
    [view setFrame:CGRectMake(view.frame.origin.x + newXVal, view.frame.origin.y, 
                              view.frame.size.width, view.frame.size.height)];
    [self addSubview:view];
    [modules addObject:view];
    numberLoaded++;
    [delagate.pageControl setNumberOfPages:numberLoaded];
}

- (void) removeFromContents:(Place *)remove {
    [remove.view removeFromSuperview];
    [modules removeObject:remove.view];
    remove.view = nil;
    numberLoaded--;
    [delagate.pageControl setNumberOfPages:numberLoaded];
}

@end
