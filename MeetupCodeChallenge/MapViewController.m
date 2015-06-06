//
//  ViewController.m
//  MeetupCodeChallenge
//
//  Created by Jessie Serrino on 6/5/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "MeetupProvider.h"

static NSString * const SegueToMeetupList = @"SegueToMeetupList";

@interface MapViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) IBOutlet MKMapView *map;
@property (nonatomic, weak)   IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak)   IBOutlet UIView *spinningWheelView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager  = [[CLLocationManager alloc] init];
    [self.manager requestAlwaysAuthorization];
    self.manager.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    sender.enabled = NO;
    
    __weak __typeof(self)weakSelf = self;
    [[MeetupProvider sharedProvider] loadMeetupsFromCoordinate:self.map.centerCoordinate completion:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf performSegueWithIdentifier:SegueToMeetupList sender:strongSelf];
        sender.enabled = YES;
        strongSelf.spinningWheelView.hidden = YES;
    } error:^(NSError * error) {
        
    }];
}


@end
