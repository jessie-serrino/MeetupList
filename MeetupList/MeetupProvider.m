//
//  MeetupProvider.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "MeetupProvider.h"
#import "MeetupInteractor.h"

static NSString * const MeetupURLString = @"https://api.meetup.com/2/open_events.json?lat=%@&lon=%@key=785132125b14757117481f145521774";


@interface MeetupProvider()
@property (nonatomic, strong) NSMutableArray *meetups;
@end

@implementation MeetupProvider

- (NSUInteger) meetupCount
{
    return self.meetups.count;
}

- (Meetup *) meetupAtIndex: (NSUInteger) index
{
    return self.meetups[index];
}

- (void) loadMeetupsWithCompletion: (CompletionBlock) completionBlock
                             error: (ErrorBlock) errorBlock
{
    
    __weak __typeof(self)weakSelf = self;
    [DataRequester requestDataFromBaseURLString:MeetupURLString parameters:nil completion:^(NSData * data) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.meetups = [MeetupInteractor meetupListWithData:data];
        completionBlock();
    } error:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
