//
//  PlaceDetailView.h
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomNavBar;

@interface PlaceDetailView : UIView {
    IBOutlet CustomNavBar * titleBar;
    IBOutlet UIView *feature;
	IBOutlet UIPageControl *pageControl;
    
    IBOutlet UILabel * weatherSuggestion;
    IBOutlet UILabel * timeSuggestion;
    IBOutlet UILabel * distanceSuggestion;
}

@property (nonatomic, retain) IBOutlet UILabel * weatherSuggestion; 
@property (nonatomic, retain) IBOutlet UILabel * timeSuggestion; 
@property (nonatomic, retain) IBOutlet UILabel * distanceSuggestion; 

- (void) setPanoramaURL: (NSString *) panoURL;
- (void) setPlaceName: (NSString* )name;
- (void) setFeatureImage:(UIImage *)featureImage;
- (void) setWeatherSuggest:(NSString *) suggestion;
- (void) setDistanceSuggest:(NSString *) suggestion;
- (void) setTimeSuggest:(NSString *) suggestion;

@end
