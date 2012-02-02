//
//  PlaceListTabButton.m
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "PlaceListTabButton.h"

@implementation PlaceListTabButton 

@synthesize active;

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel setFont:[UIFont fontWithName:@"nevis" size:13.0f]];
        [self setBackgroundImage:[UIImage imageNamed:@"listTabInactive.png"] forState:UIControlStateNormal];
        [self setContentEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self.titleLabel setFont:[UIFont fontWithName:@"nevis" size:self.titleLabel.font.pointSize]];
        active = YES ? self.titleLabel.font.pointSize == 15 : NO;
    }
    return self;
}

- (void) setActive {
    [self setBackgroundImage:[UIImage imageNamed:@"listTabActive.png"] forState:UIControlStateNormal];
    active = YES;
}

- (void) setInactive {
    [self setBackgroundImage:[UIImage imageNamed:@"listTabInactive.png"] forState:UIControlStateNormal];
    active = NO;
}

- (void) toggleActive {
    if (active) {
        [self setInactive];
    } else {
        [self setActive];
    }
}

@end
