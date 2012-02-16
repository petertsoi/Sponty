//
//  AsynchronousImageView.h
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define IS_RETINA [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2
static inline double radians (double degrees) {return degrees * M_PI/180;}

@interface AsynchronousImageView : UIImageView {
    NSURLConnection *connection;
    NSMutableData *data;

    UIActivityIndicatorView * spinner;
    bool isLoaded;
}

@property (nonatomic) bool isLoaded;

- (void)loadImageFromURLString:(NSString *)theUrlString;

@end