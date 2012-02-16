//
//  PlaceListView.m
//  Sponty
//
//  Created by Peter Tsoi on 2/1/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import "PlaceListView.h"
#import "PlaceTableView.h"

#import "PlaceListTabButton.h"
#import "PlaceViewController.h"

@implementation PlaceListView

@synthesize tableView;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        currentTab = allTab;
        tabs = [[NSMutableArray alloc] initWithObjects:allTab, nil];
    }
    return self;
}

- (void) addTab:(NSString *)title {
    
    PlaceListTabButton * lastTab = [tabs lastObject];
    if (!lastTab) {
        tabs = [[NSMutableArray alloc] initWithObjects:allTab, nil];
        lastTab = [tabs lastObject];
    }
    PlaceListTabButton * newTab = [[PlaceListTabButton alloc] initWithFrame:lastTab.frame];
    newTab.center = CGPointMake(lastTab.center.x, lastTab.center.y+65);
    [newTab setTitle:title forState:UIControlStateNormal];
    [tabs addObject:newTab];
    [newTab addTarget:self action:@selector(tabPressed:) forControlEvents:UIControlEventTouchUpInside]; 
    [self insertSubview:newTab aboveSubview:lastTab];
}

- (IBAction)tabPressed:(id)sender {
    if (!currentTab) {
        currentTab = allTab;
    }
    if (!((PlaceListTabButton*)sender).active) {
        [currentTab toggleActive];
        currentTab = sender;
        [currentTab toggleActive];
        [delegate switchToListFilter:[tabs indexOfObject:currentTab]];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview touchesMoved:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview touchesEnded:touches withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
