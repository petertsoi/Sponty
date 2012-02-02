//
//  PlaceListViewCell.h
//  Sponty
//
//  Created by Peter Tsoi on 2/2/12.
//  Copyright (c) 2012 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceListViewCell : UITableViewCell {
    IBOutlet UILabel * placeNameLabel;
    IBOutlet UILabel * distanceLabel;
}

@property(nonatomic,retain) IBOutlet UILabel * placeNameLabel;
@property(nonatomic,retain) IBOutlet UILabel * distanceLabel;

@end
