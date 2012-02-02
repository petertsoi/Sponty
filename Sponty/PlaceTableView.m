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

@end
