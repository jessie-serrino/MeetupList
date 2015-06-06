//
//  Models.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "Meetup.h"

@implementation Meetup

- (instancetype)initWithName: (NSString *) meetupName
                       group: (NSString *) groupName
                 description: (NSString *) description
                         url: (NSURL *) url
                   eventDate: (NSDate *) actualDate
                creationDate: (NSDate *) creationDate
                   rsvpCount: (NSUInteger) rsvpCount
                    distance: (float) distance
                       venue: (Venue *) venue
{
    self = [super init];
    if(self) {
        _meetupName = meetupName;
        _groupName = groupName;
        _meetupDescription = description;
        _meetupURL = url;
        _eventDate = actualDate;
        _creationDate = creationDate;
        _rsvpCount = rsvpCount;
        _distance = distance;
        _venue = venue;
    }
    return self;
}

@end
