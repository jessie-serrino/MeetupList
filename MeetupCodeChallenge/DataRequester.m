//
//  DataRequester.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "AFNetworking/AFNetworking.h"
#import "DataRequester.h"
#import "NSURL+Parameters.h"


@implementation DataRequester

- (void) requestDataFromBaseURLString:(NSString *) baseURLString parameters:(NSDictionary *)parameters completion:(DataBlock)completionBlock error:(ErrorBlock)errorBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString: baseURLString ]];
    
    [manager GET:@"open_events"
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             completionBlock(responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             errorBlock(error);
         }];
}

@end
