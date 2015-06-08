//
//  Venue.h
//  MeetupList
//
//  Created by Jessie Serrino on 6/5/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

@import Foundation;
@import MapKit;

@interface Venue : NSObject

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, strong) NSString *placeName;

@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSString * stateName;
@property (nonatomic, strong) NSString *address;

- (instancetype)initWithCoordinate: (CLLocationCoordinate2D) coordinates
                              place: (NSString *) placeName
                               city: (NSString *) cityName
                              state: (NSString *) state
                            address:(NSString *) address;

- (NSString *) partialAddress;

@end
