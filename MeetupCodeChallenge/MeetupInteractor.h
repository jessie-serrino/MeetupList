//
//  BookInteractor.h
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Meetup.h"

@interface MeetupInteractor : NSObject

+ (NSArray *) meetupListWithData: (NSData *) data;

@end
