//
//  MapViewController
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

@import MapKit;

#import <CoreLocation/CoreLocation.h>
#import "MapViewController2.h"
#import "MKMapView+Center.h"

#import "MeetupProvider.h"


static NSString * const SegueToMeetupList = @"SegueToMeetupList";

@interface MapViewController2 () <CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UIView *spinningWheelView;

@end

@implementation MapViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization]; // Add This Line
  //  [self.locationManager startUpdatingLocation];
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
}

//- (void) prepareLocationManager
//{
//    _locationManager = [[CLLocationManager alloc] init];
//    self.map.showsUserLocation = YES;
//    
//    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//        [self.locationManager requestAlwaysAuthorization];
//        self.locationManager.delegate = self;
//
//    } else {
//        [self.locationManager startUpdatingLocation];
//    }
//}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.map centerMap:userLocation.coordinate withRectSize:CGSizeMake(1000.0, 1000.0)];
}

//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    if (status == kCLAuthorizationStatusAuthorizedAlways ||
//        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
//        [manager startUpdatingLocation];
//        [self.map centerMap:manager.location.coordinate withRectSize:CGSizeMake(1000.0, 1000.0)];
//        
//    }
//    else {
//        // The White House
//        [self.map centerMap:CLLocationCoordinate2DMake(38.8977, -77.0366) withRectSize:CGSizeMake(1000.0, 1000.0)];
//    }
//}

- (CLGeocoder *)geocoder
{
    if(!_geocoder){
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    self.doneButton.enabled = NO;
    self.spinningWheelView.hidden = NO;
    
    __weak __typeof(self)weakSelf = self;
    [[MeetupProvider sharedProvider] loadMeetupsFromCoordinate:self.map.centerCoordinate completion:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf performSegueWithIdentifier:SegueToMeetupList sender:strongSelf];
        strongSelf.doneButton.enabled = YES;
        strongSelf.spinningWheelView.hidden = YES;
    } error:^(NSError * error) {
        
    }];
}






@end
