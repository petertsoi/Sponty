//
//  PlaceListHeaderView.m
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "PlaceListHeaderView.h"

@implementation PlaceListHeaderView

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 15, 0, 15};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
