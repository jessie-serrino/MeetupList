//
//  BookInteractor.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "MeetupInteractor.h"


@implementation MeetupInteractor

+ (NSArray *) meetupListWithData: (NSData *) data
{
    NSError *error;
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:&error];
    NSArray *meetups;
    if(dataDictionary[@"results"]){
        meetups = [MeetupInteractor arrayOfMeetupsFromArray: dataDictionary[@"results"]];
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


//_meetupName = meetupName;
//_groupName = groupName;
//_meetupDescription = description;
//_meetupURL = url;
//_eventDate = actualDate;
//_creationDate = creationDate;
//_rsvpCount = rsvpCount;
//_distance = distance;
//_venue = venue;

+ (Meetup *) meetupWithDictionary: (NSDictionary *) meetupDictionary
{
    NSString *name = meetupDictionary[@"name"]; //
    NSString *groupName = meetupDictionary[@"group"][@"name"]; //
    NSString *description = meetupDictionary[@"description"]; //

    NSString *urlString = meetupDictionary[@"event_url"]; //
    NSURL *url = [NSURL URLWithString:urlString]; //
    
    NSUInteger eventDateTime = [meetupDictionary[@"time"] integerValue];
    NSDate *eventDate = [NSDate dateWithTimeIntervalSince1970:(eventDateTime / 1000)];
    
    NSUInteger creationDateTime = [meetupDictionary[@"created"] integerValue];
    NSDate *creationDate = [NSDate dateWithTimeIntervalSince1970:(creationDateTime / 1000)];
    
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


//_coordinates = coordinates;
//_placeName = placeName;
//_cityName = cityName;
//_stateName = state;
//_address = address;

+ (Venue *) venueWithDictionary: (NSDictionary *) venueDictionary
{
    float latitude = [venueDictionary[@"lat"] doubleValue];
    float longitude = [venueDictionary[@"lon"] doubleValue];
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(latitude, longitude);
    
    NSString *placeName = venueDictionary[@"name"];
    NSString *cityName = venueDictionary[@"city"];
    NSString *stateName = venueDictionary[@"state"];
    NSString *address = venueDictionary[@"address_1"];

    return [[Venue alloc] initWithCoordinates:coordinates
                                        place:placeName
                                         city:cityName
                                        state:stateName
                                      address:address];
}

@end
