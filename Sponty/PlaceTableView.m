//
//  PlaceTableView.m
//  Sponty
//
//  Created by Peter Tsoi on 2/1/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "PlaceTableView.h"

@implementation PlaceTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) awakeFromNib {
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"listbg.png"]];
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    touchBeganLocation = [[touches anyObject] locationInView:self.superview.superview];
    [self.superview touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint curTouchLocation = [[touches anyObject] locationInView:self.superview.superview];
    if (fabsf(curTouchLocation.x - touchBeganLocation.x) > 7.0f) 
        [self.superview touchesMoved:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint curTouchLocation = [[touches anyObject] locationInView:self.superview.superview];
    float dx = fabsf(curTouchLocation.x - touchBeganLocation.x);
    float dy = fabs(curTouchLocation.y - touchBeganLocation.y);
    if (dx > 7.0f && dx/dy > 2.0f) {
        [super touchesCancelled:touches withEvent:event];
        [self.superview touchesEnded:touches withEvent:event];
    } else {
        [super touchesEnded:touches withEvent:event];
        [self.superview touchesEnded:touches withEvent:event];
    }
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

@end
