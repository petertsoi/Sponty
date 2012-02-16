//
//  CustomTextField.m
//  Sponty
//
//  Created by Peter Tsoi on 2/15/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 10 );
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 10 );
}

@end
