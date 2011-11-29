//
//  PlaceDetailView.h
//  Sponty
//
//  Created by Peter Tsoi on 11/28/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceDetailView : UIView {
    IBOutlet UINavigationBar * titleBar;
    IBOutlet UIScrollView *scrollView;
	IBOutlet UIPageControl *pageControl;
}

- (void) setPlaceName: (NSString* )name;

@end
