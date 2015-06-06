//
//  MKMapView+Center.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "MKMapView+Center.h"

@implementation MKMapView (Center)

- (void) centerMap: (CLLocationCoordinate2D) coordinate withRectSize: (CGSize) box
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, box.width, box.height);
    MKCoordinateRegion adjustedRegion = [self regionThatFits:viewRegion];
    [self setRegion:adjustedRegion animated:YES];
}


@end
