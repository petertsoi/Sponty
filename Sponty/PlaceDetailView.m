//
//  PlaceDetailView.m
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "PlaceDetailView.h"

#import "CustomNavBar.h"

@implementation PlaceDetailView

@synthesize weatherSuggestion, distanceSuggestion, timeSuggestion;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) setPlaceName: (NSString* )name {
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PlacePageBG"]]];
    [titleBar setTitle:name];
}

- (void) setFeatureImage:(UIImage *)featureImage {
    [feature setBackgroundColor:[UIColor colorWithPatternImage:featureImage]];
}

- (void) setDistanceSuggest:(NSString *) suggestion{
    [distanceSuggestion setText:suggestion];
}

- (void) setWeatherSuggest:(NSString *) suggestion{
    weatherSuggestion.text = suggestion;
}

- (void) setTimeSuggest:(NSString *) suggestion{
    timeSuggestion.text = suggestion;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect
{
    
}


@end
