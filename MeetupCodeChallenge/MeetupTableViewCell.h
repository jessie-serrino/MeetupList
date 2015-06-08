//
//  MeetupTableViewCell.h
//  MeetupCodeChallenge
//
//  Created by Jessie Serrino on 6/6/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meetup.h"

@interface MeetupTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;

- (void) setMeetup: (Meetup *) meetup;


@end
