//
//  MKMapView+Center.h
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (Center)

- (void) centerMap: (CLLocationCoordinate2D) coordinate withRectSize: (CGSize) box;

@end
