//
//  MeetupTableViewController.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/5/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "MeetupTableViewController.h"
#import "MeetupTableViewCell.h"
#import "MeetupProvider.h"

static NSString * const SegueToDetail = @"SegueToDetail";

@interface MeetupTableViewController ()
@property (nonatomic, weak) MeetupProvider *provider;
@end

@implementation MeetupTableViewController

- (MeetupProvider *)provider
{
    if(!_provider)
    {
        _provider = [MeetupProvider sharedProvider];
    }
    return _provider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView registerNib:[UINib nibWithNibName:@"MeetupTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MeetupTableViewCell"];
    //[self.tableView registerClass:[MeetupTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MeetupTableViewCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.provider.meetupCount;
}



- (MeetupTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeetupTableViewCell class]) forIndexPath:indexPath];
    
    Meetup *meetup = [self.provider meetupAtIndex:indexPath.row];
    [cell setMeetup:meetup];
//    cell.textLabel.text = meetup.meetupName;
//    cell.detailTextLabel.text = meetup.groupName;
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.provider selectMeetupAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:SegueToDetail sender:self];
}


@end
