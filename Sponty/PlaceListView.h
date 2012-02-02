//
//  PlaceListView.h
//  Sponty
//
//  Created by Peter Tsoi on 2/1/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaceTableView;
@class PlaceListTabButton;
@class PlaceViewController;

@interface PlaceListView : UIView {
    PlaceListTabButton * currentTab;
    IBOutlet PlaceListTabButton * allTab;
    IBOutlet PlaceViewController * delegate;
    IBOutlet UITableView * tableView;
    
    NSMutableArray * tabs;
}

@property (nonatomic, retain) IBOutlet UITableView * tableView;

- (IBAction)tabPressed:(id)sender;
- (void) addTab:(NSString *)title;

@end
