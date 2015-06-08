//
//  MeetupProvider.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "MeetupProvider.h"
#import "MeetupInteractor.h"

static NSString * const MeetupURLString = @"https://api.meetup.com/2";
static NSString * const APIKey = @"785132125b14757117481f145521774";
static NSString * const TopicString = @"technology";




@interface MeetupProvider()
@property (nonatomic, strong) NSArray *meetups;
@property (nonatomic) NSUInteger selectedMeetupIndex;
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

- (Meetup *) meetupAtIndex: (NSUInteger) index
{
    return self.meetups[index];
}

- (void) selectMeetupAtIndex: (NSUInteger) index
{
    self.selectedMeetupIndex = index;
}

- (Meetup *) selectedMeetup
{
    return [self.meetups objectAtIndex:self.selectedMeetupIndex];
}

- (NSDictionary *) parameterDictionaryWithCoordiante: (CLLocationCoordinate2D) coordinate
{
    NSString *latitudeString = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    return @{@"lat":latitudeString,
                                 @"lon":longitudeString,
                                 @"topic":TopicString,
                                 @"key": APIKey};
}

- (void) loadMeetupsFromCoordinate: (CLLocationCoordinate2D) coordinate
                        completion: (CompletionBlock) completionBlock
                             error: (ReportErrorBlock) errorBlock;
{
    NSDictionary *parameters = [self parameterDictionaryWithCoordiante:coordinate];
    
    __weak __typeof(self)weakSelf = self;
    [self requestDataFromBaseURLString:MeetupURLString
                                     parameters:parameters
                                     completion:^(NSDictionary * dataDictionary) {
                                         __strong __typeof(weakSelf)strongSelf = weakSelf;
                                        strongSelf.meetups  =[MeetupInteractor meetupListWithDictionary:dataDictionary];
                                         if(strongSelf.meetups.count)
                                             completionBlock();
                                         else
                                             errorBlock(@"No Results Found");
                                     } error:^(NSError *error) {
                                         errorBlock(@"Unable to Access the Server.");
                                     }];
}

@end
