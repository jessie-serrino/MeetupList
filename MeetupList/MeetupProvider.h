//
//  MeetupProvider.h
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Meetup.h"
#import "DataRequester.h"

typedef void (^CompletionBlock)();


@interface MeetupProvider : NSObject

- (NSUInteger) meetupCount;
- (Meetup *) meetupAtIndex: (NSUInteger) index;

- (void) loadMeetupsWithCompletion: (CompletionBlock) completionBlock
                             error: (ErrorBlock) errorBlock;

@end
