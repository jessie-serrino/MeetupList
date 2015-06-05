//
//  MapViewController
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "MapViewController.h"
#import "MKMapView+Center.h"

//#import "PoliticianTableViewController.h"
//#import "PoliticianInteractor.h"


@import MapKit;


@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UIView *spinningWheelView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareLocationManager];

    self.map.delegate = self;
    NSDictionary *dict = @{@"key":@"value", @"key2":@"value2"};
    
}

- (void) prepareLocationManager
{
    _locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    } else {
        // iOS 7 - We can't use requestWhenInUseAuthorization -- we'll get an unknown selector crash!
        // Instead, you just start updating location, and the OS will take care of prompting the user
        // for permissions.
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    // We only need to start updating location for iOS 8 -- iOS 7 users should have already
    // started getting location updates
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager startUpdatingLocation];
        [self.map centerMap:manager.location.coordinate withRectSize:CGSizeMake(1000.0, 1000.0)];
        
    }
    else {
        // The White House
        [self.map centerMap:CLLocationCoordinate2DMake(38.8977, -77.0366) withRectSize:CGSizeMake(1000.0, 1000.0)];
    }
}

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

//    [[PoliticianProvider sharedProvider] loadPoliticiansFromLocation:self.map.centerCoordinate completion:^(NSDictionary *data) {
//        self.spinningWheelView.hidden = YES;
//        if([[PoliticianInteractor sharedInteractor] politiciansWithData:data])
//        {
//            
//            [self setError:NO];
//            [self performSegueWithIdentifier: @"SegueToMeetupList" sender:self];
//        }
//        else
//        {
//            [self setError:YES];
//        }
//        self.doneButton.enabled = YES;
//        
//    } error:^(id data, NSError *error) {
//        self.spinningWheelView.hidden = NO;
//        UIAlertController *uialert = [UIAlertController alertControllerWithTitle:@"No Internet Connection" message:@"You appear to be offline. Please connect to Internet to proceed." preferredStyle:UIAlertControllerStyleAlert];
//        [uialert addAction:[UIAlertAction
//           actionWithTitle:@"Ok"
//                     style:UIAlertActionStyleDefault
//                   handler:^(UIAlertAction *action)
//                     {
//                     
//                     }]];
//        [self presentViewController:uialert animated:YES completion:nil];
//        
//        self.doneButton.enabled = YES;
//    }];
    
}


//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    [searchBar resignFirstResponder];
//    NSString *address = searchBar.text;
//    MKMapView *map = self.map;
//    [self.geocoder geocodeAddressString:address
//                 completionHandler:^(NSArray* placemarks, NSError* error){
//                     if(placemarks.count > 0)
//                     {
//                         CLPlacemark *placemark = placemarks[0];
//                         [MapViewController setMapCenter:placemark.location.coordinate map:map];
//                     }
//                 }];
//}






@end
