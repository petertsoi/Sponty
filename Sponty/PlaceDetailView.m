//
//  PlaceDetailView.m
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import "PlaceDetailView.h"

#import "AsynchronousImageView.h"
#import "CustomNavBar.h"

@implementation PlaceDetailView

@synthesize weatherSuggestion, distanceSuggestion, timeSuggestion;
@synthesize place = mData;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) setPlace:(Place *) data {
    mData = data;
}

- (void) setPanoramaURL: (NSString *) panoURL {
    UIWebView * panoView = [[UIWebView alloc] initWithFrame:feature.frame];
    
    NSURL * reqURL = [NSURL URLWithString:panoURL];
    NSURLRequest * reqObj = [NSURLRequest requestWithURL:reqURL];
    [panoView loadRequest:reqObj];
    [feature addSubview:panoView];
}

- (void) setPlaceName: (NSString* )name {
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PlacePageBG"]]];
    [titleBar setTitle:name];
    
    [self setFrame:CGRectMake(self.frame.origin.x+10, self.frame.origin.y, 
                              self.frame.size.width-20, self.frame.size.height-20)];
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
}

- (void) setFeatureImage:(NSString *)imgURL {
    AsynchronousImageView * newImage = [[AsynchronousImageView alloc] initWithFrame:feature.frame];
    [newImage loadImageFromURLString:imgURL];
    [feature addSubview:newImage];
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
