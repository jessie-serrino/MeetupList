//
//  DataRequester.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "DataRequester.h"
#import "NSURL+Parameters.h"


@implementation DataRequester

+ (void) requestDataFromBaseURLString:(NSString *) baseURLString parameters:(NSDictionary *)parameters completion:(DataBlock)completionBlock error:(ErrorBlock)errorBlock
{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL urlWithBaseString:baseURLString parameters:parameters]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if(error)
                    errorBlock(error);
                else
                    completionBlock(data);
                
            }] resume];
}



@end
