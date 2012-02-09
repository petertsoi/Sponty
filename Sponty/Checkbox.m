//
//  Checkbox.m
//  Sponty
//
//  Created by Peter Tsoi on 2/8/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "Checkbox.h"

@implementation Checkbox 

@synthesize checked = mChecked;

- (void) setChecked:(_Bool)checked {
    if (checked) {
        [self setBackgroundImage:[UIImage imageNamed:@"CheckboxChecked.png"] forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:[UIImage imageNamed:@"CheckboxUnchecked.png"] forState:UIControlStateNormal];
    }
    mChecked = checked;
}

@end
