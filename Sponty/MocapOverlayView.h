//
//  MocapOverlayView.h
//  Sponty
//
//  Created by Peter Tsoi on 12/1/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MocapOverlayView : UIView {
    UIView * mSuperView;
}

- (id)initWithSuperView:(UIView *)superview;

@end
