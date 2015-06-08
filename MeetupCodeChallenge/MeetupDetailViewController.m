//
//  MeetupDetailViewController.m
//  MeetupCodeChallenge
//
//  Created by Jessie Serrino on 6/6/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

@import MapKit;

#import "MeetupDetailViewController.h"
#import "MKMapView+Center.h"
#import "MeetupProvider.h"
#import "MHPrettyDate.h"

static NSString * const MilesAway = @"%.f miles away";

@interface MeetupDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *groupLabel;
@property (strong, nonatomic) IBOutlet UIButton *urlButton;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UIButton *directionsButton;
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) Meetup *meetup;

@end

@implementation MeetupDetailViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self prepareLabels];
    [self prepareMap];
}

- (Meetup *)meetup
{
    if(!_meetup) {
        _meetup = [MeetupProvider sharedProvider].selectedMeetup;
    }
    return _meetup;
}

- (void) prepareLabels
{
    Meetup *meetup = self.meetup;
    self.nameLabel.text = meetup.meetupName;
    self.groupLabel.text = meetup.groupName;
    self.timeLabel.text = [MHPrettyDate prettyDateFromDate:meetup.eventDate withFormat:MHPrettyDateFormatWithTime];
    self.distanceLabel.text = [NSString stringWithFormat:MilesAway, meetup.distance];
                           
    [self.urlButton setTitle:meetup.meetupURL.description forState:UIControlStateNormal];
    [self.directionsButton setTitle:meetup.venue.partialAddress forState:UIControlStateNormal];
}

- (void) prepareMap
{
    MKPointAnnotation *point =[self annotationWithVenue:self.meetup.venue];
    [self.map addAnnotation:point];
    [self.map centerMap:point.coordinate withRectSize:CGSizeMake(1000.0, 1000.0)];
}

- (MKPointAnnotation *) annotationWithVenue: (Venue *) venue
{
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = venue.coordinate;
    point.title = venue.partialAddress;
    
    return point;
}

// URL button opens URL
- (IBAction)urlButtonPressed:(id)sender {
    if(self.meetup.meetupURL)
        [[UIApplication sharedApplication] openURL:self.meetup.meetupURL];
}

// Directions to the place
- (IBAction)addressButtonPressed:(id)sender {
    if(self.meetup.venue)
        [self openMapWithDirectionsFromCoordinate:self.meetup.venue.coordinate];
}

- (void) openMapWithDirectionsFromCoordinate: (CLLocationCoordinate2D) coordinate
{
    MKPlacemark *endLocation = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem *endingItem = [[MKMapItem alloc] initWithPlacemark:endLocation];
    
    NSMutableDictionary *launchOptions = [[NSMutableDictionary alloc] init];
    [launchOptions setObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];

    [endingItem openInMapsWithLaunchOptions:launchOptions];
}

@end
