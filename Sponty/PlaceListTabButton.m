//
//  PlaceListTabButton.m
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "PlaceListTabButton.h"

@implementation PlaceListTabButton 

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self.titleLabel setFont:[UIFont fontWithName:@"nevis" size:self.titleLabel.font.pointSize]];
    }
    return self;
}


@end
