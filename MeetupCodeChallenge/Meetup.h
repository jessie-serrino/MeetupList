//
//  Models.h
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Venue.h"

@interface Meetup : NSObject

@property (nonatomic, strong) NSString *meetupName;
@property (nonatomic, strong) NSString *groupName;

@property (nonatomic, strong) NSString *meetupDescription;
@property (nonatomic)         NSURL *meetupURL;

@property (nonatomic, strong) NSDate *eventDate;
@property (nonatomic, strong) NSDate *creationDate;

@property (nonatomic)         NSUInteger rsvpCount;

@property (nonatomic)         float distance;
@property (nonatomic, strong) Venue *venue;

- (instancetype)initWithName: (NSString *) meetupName
                       group: (NSString *) groupName
                 description: (NSString *) description
                         url: (NSURL *) url
                   eventDate: (NSDate *) actualDate
                creationDate: (NSDate *) creationDate
                   rsvpCount: (NSUInteger) rsvpCount
                    distance: (float) distance
                       venue: (Venue *) venue;




@end
