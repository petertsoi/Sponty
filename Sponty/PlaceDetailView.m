//
//  PlaceDetailView.m
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "PlaceDetailView.h"

@implementation PlaceDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) setPlaceName: (NSString* )name {
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PlacePageBG"]]];
    titleBar.topItem.title = name;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect
{
    
}


@end
