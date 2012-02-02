//
//  PlaceListTabButton.h
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceListTabButton : UIButton {
    bool active;
}
@property (nonatomic) bool active;

- (void) setActive;
- (void) setInactive;
- (void) toggleActive;

@end
