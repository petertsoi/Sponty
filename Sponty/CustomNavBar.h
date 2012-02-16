//
//  CustomNavBar.h
//  Sponty
//
//  Created by Peter Tsoi on 11/27/11.
//  Copyright (c) 2011 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavBar : UINavigationBar {
    UILabel * titleLabel;
}

//@property (nonatomic) UIView * backgroundView;

- (void) setTitle:(NSString *) newTitle;

@end
