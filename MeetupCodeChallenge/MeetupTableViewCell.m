//
//  MeetupTableViewCell.m
//  MeetupCodeChallenge
//
//  Created by Jessie Serrino on 6/6/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "MeetupTableViewCell.h"
#import "MHPrettyDate/MHPrettyDate.h"

static NSString * const MilesAway = @"%.f miles away";

@interface MeetupTableViewCell()
@property (strong, nonatomic) Meetup *meetup;

@end

@implementation MeetupTableViewCell

- (void) configureVisuals
{
    self.nameLabel.text = self.meetup.meetupName;
    self.timeLabel.text = [MHPrettyDate prettyDateFromDate:self.meetup.eventDate withFormat:MHPrettyDateFormatWithTime];
    self.distanceLabel.text = [NSString stringWithFormat:MilesAway, self.meetup.distance];
}

- (void)setMeetup:(Meetup *)meetup
{
    _meetup = meetup;
    [self configureVisuals];
}


@end
