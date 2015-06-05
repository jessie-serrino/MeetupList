//
//  DataRequester.h
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DataBlock)(NSData *);
typedef void (^ErrorBlock)(NSError *);

@interface DataRequester : NSObject

+ (void) requestDataFromBaseURLString:(NSString *) baseURLString
                     parameters: (NSDictionary *) parameters
                     completion: (DataBlock) completionBlock error: (ErrorBlock) errorBlock;

@end
