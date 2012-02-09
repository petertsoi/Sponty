//
//  Checkbox.h
//  Sponty
//
//  Created by Peter Tsoi on 2/8/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Checkbox : UIButton {
    bool mChecked;
    bool mExclusive;
}

@property (nonatomic) bool checked;

@end
