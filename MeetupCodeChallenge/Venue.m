//
//  Venue.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/5/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (instancetype)initWithCoordinate: (CLLocationCoordinate2D) coordinates
                              place: (NSString *) placeName
                               city: (NSString *) cityName
                              state: (NSString *) state
                            address:(NSString *) address
{
    self = [super init];
    if(self)    {
        _coordinate = coordinates;
        _placeName = placeName;
        _cityName = cityName;
        _stateName = state;
        _address = address;
    }
    return self;
}

- (NSString *) partialAddress
{
    return [NSString stringWithFormat:@"%@, %@", self.address, self.cityName];
}

@end
