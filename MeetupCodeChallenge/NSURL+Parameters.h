//
//  NSURL+Parameters.h
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Parameters)

+ (NSURL *) urlWithBaseString: (NSString *) baseURLString parameters: (NSDictionary *) parameters;

@end
