//
//  BookInteractor.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "MeetupInteractor.h"


@implementation MeetupInteractor

+ (NSArray *) meetupListWithDictionary: (NSDictionary *) meetupsDictionary
{
    NSArray *meetups;
    if(meetupsDictionary[@"results"]){
        meetups = [MeetupInteractor arrayOfMeetupsFromArray: meetupsDictionary[@"results"]];
    }
    return meetups;
}

+ (NSArray *) arrayOfMeetupsFromArray: (NSArray *) array
{
    NSMutableArray *meetups = [[NSMutableArray alloc] initWithCapacity:array.count];
    for(NSDictionary *meetupDictionary in array){
        [meetups addObject:[MeetupInteractor meetupWithDictionary:meetupDictionary]];
    }
    return meetups;
}


+ (Meetup *) meetupWithDictionary: (NSDictionary *) meetupDictionary
{
    NSString *name = meetupDictionary[@"name"];
    NSString *groupName = meetupDictionary[@"group"][@"name"];
    NSString *description = meetupDictionary[@"description"];

    NSString *urlString = meetupDictionary[@"event_url"];
    NSURL *url = [NSURL URLWithString:urlString]; //
    
    NSNumber *eventDateTime = meetupDictionary[@"time"];
    long long epochEventTime = [eventDateTime longLongValue] / 1000;
    NSDate *eventDate = [NSDate dateWithTimeIntervalSince1970:epochEventTime];
    
    NSNumber *creationDateTime = meetupDictionary[@"created"];
    long long epochCreationTime = [creationDateTime longLongValue] / 1000;
    NSDate *creationDate = [NSDate dateWithTimeIntervalSince1970:epochCreationTime];
    
    NSUInteger rsvpCount = [meetupDictionary[@"yes_rsvp_count"] integerValue] / 1000;
    float distance = [meetupDictionary[@"distance"] floatValue];
    Venue *venue = [MeetupInteractor venueWithDictionary:meetupDictionary[@"venue"]];
    
    
    return [[Meetup alloc] initWithName:name
                                  group:groupName
                            description:description
                                    url:url
                              eventDate:eventDate
                           creationDate:creationDate
                              rsvpCount:rsvpCount
                               distance:distance
                                  venue:venue];
}


+ (Venue *) venueWithDictionary: (NSDictionary *) venueDictionary
{
    float latitude = [venueDictionary[@"lat"] doubleValue];
    float longitude = [venueDictionary[@"lon"] doubleValue];
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(latitude, longitude);
    
    NSString *placeName = venueDictionary[@"name"];
    NSString *cityName = venueDictionary[@"city"];
    NSString *stateName = venueDictionary[@"state"];
    NSString *address = venueDictionary[@"address_1"];

    return [[Venue alloc] initWithCoordinate:coordinates
                                        place:placeName
                                         city:cityName
                                        state:stateName
                                      address:address];
}

@end
