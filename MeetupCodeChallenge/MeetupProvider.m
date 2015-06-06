//
//  MeetupProvider.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "MeetupProvider.h"
#import "MeetupInteractor.h"

static NSString * const MeetupURLString = @"https://api.meetup.com/2/open_events.json";
static NSString * const APIKey = @"785132125b14757117481f145521774";
static NSString * const TopicString = @"technology";


@interface MeetupProvider()
@property (nonatomic, strong) NSMutableArray *meetups;
@end

@implementation MeetupProvider

+ (instancetype) sharedProvider
{
    static MeetupProvider *provider = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        provider = [[self alloc] init];
    });
    return provider;
}

- (NSUInteger) meetupCount
{
    return self.meetups.count;
}

- (NSMutableArray *) meetups
{
    if(!_meetups){
        _meetups = [[NSMutableArray alloc] init];
    }
    return _meetups;
}

- (Meetup *) meetupAtIndex: (NSUInteger) index
{
    return self.meetups[index];
}

- (void) loadMeetupsFromCoordinate: (CLLocationCoordinate2D) coordinate
                        completion: (CompletionBlock) completionBlock
                             error: (ErrorBlock) errorBlock;
{
    NSString *latitudeString = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f", coordinate.longitude];

    NSDictionary *parameters = @{@"lat":latitudeString,
                                 @"lon":longitudeString,
                                 @"topic":TopicString,
                                 @"key": APIKey};
    __weak __typeof(self)weakSelf = self;
    
    [DataRequester requestDataFromBaseURLString:MeetupURLString
                                     parameters:parameters
                                     completion:^(NSData * data) {
                                         __strong __typeof(weakSelf)strongSelf = weakSelf;
                                        [strongSelf.meetups addObjectsFromArray: [MeetupInteractor meetupListWithData:data]];
                                        completionBlock();
                                     } error:^(NSError *error) {
                                         errorBlock(error);
                                     }];
}

@end
