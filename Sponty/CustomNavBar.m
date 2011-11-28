//
//  CustomNavBar.m
//  Sponty
//
//  Created by Peter Tsoi on 11/27/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "CustomNavBar.h"

@implementation CustomNavBar

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 
                                self.frame.size.width, 53);
        [self setBackgroundImage:[UIImage imageNamed:@"CustomNavBG.png"] forBarMetrics:UIBarMetricsDefault];
        [[CustomNavBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], UITextAttributeTextColor, 
          [UIColor colorWithRed:199.0/255.0 green:21.0/255.0 blue:67.0/255.0 alpha:0.98], UITextAttributeTextShadowColor, 
          [NSValue valueWithUIOffset:UIOffsetMake(1.5, 0.7)], UITextAttributeTextShadowOffset, 
          [UIFont fontWithName:@"Santa Fe LET" size:32.0], UITextAttributeFont, 
          nil]];
        [self setBarStyle:UIBarStyleBlackOpaque];
        return self;
    }
    return nil;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    for (UIView * view in [self subviews]) {
        if (view.frame.size.width != self.frame.size.width)
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - 8.0f, 
                                view.frame.size.width, view.frame.size.height);
    }
}

@end
