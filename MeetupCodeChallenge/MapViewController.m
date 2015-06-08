//
//  ViewController.m
//  MeetupCodeChallenge
//
//  Created by Jessie Serrino on 6/5/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "MapViewController.h"
#import "MKMapView+Center.h"
#import "MeetupProvider.h"




static NSString * const SegueToMeetupList = @"SegueToMeetupList";

@interface MapViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic)         BOOL centeredMap;
@property (nonatomic, weak)   UIView *spinningWheelView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureSpinningWheelView];
    [self startLocationManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) configureSpinningWheelView
{
    self.spinningWheelView = [[NSBundle mainBundle] loadNibNamed:@"SpinningWheelView" owner:self options:nil][0];
    self.spinningWheelView.hidden = YES;
    self.spinningWheelView.center = self.view.center;
    [self.view addSubview:self.spinningWheelView];
    [self loadingScreenActive:NO];
}

- (void) startLocationManager
{
    self.centeredMap = NO;
    self.locationManager  = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(!self.centeredMap){
        CLLocation *location = [locations lastObject];
        [self.map centerMap:location.coordinate withRectSize:CGSizeMake(1000.0, 1000.0)];
        self.centeredMap = YES;
    }
}

- (void) loadingScreenActive: (BOOL) active
{
    self.spinningWheelView.hidden = !active;
    self.map.scrollEnabled = !active;
    self.map.zoomEnabled = !active;
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    sender.enabled = NO;
    
    [self loadingScreenActive:YES];
    __weak __typeof(self)weakSelf = self;
    [[MeetupProvider sharedProvider] loadMeetupsFromCoordinate:self.map.centerCoordinate completion:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf endQueryWithSuccess:sender];

    } error:^(NSString * error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf endQueryWithFailure:sender description:error];
        
    }];
}

- (void) endQueryWithSuccess: (UIBarButtonItem *) sender
{
    [self endQuery:sender];
    [self performSegueWithIdentifier: SegueToMeetupList sender:self];
}

- (void) endQueryWithFailure: (UIBarButtonItem *) sender description: (NSString *) description
{
    [self endQuery:sender];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:description
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) endQuery: (UIBarButtonItem *) sender
{
    sender.enabled = YES;
    [self loadingScreenActive:NO];
}

@end
