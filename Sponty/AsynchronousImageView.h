//
//  AsynchronousImageView.h
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AsynchronousImageView : UIImageView {
    NSURLConnection *connection;    NSMutableData *data;}                           

- (void)loadImageFromURLString:(NSString *)theUrlString;

@end