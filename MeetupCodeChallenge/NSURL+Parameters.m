//
//  NSURL+Parameters.m
//  MeetupList
//
//  Created by Jessie Serrino on 6/4/15.
//  Copyright (c) 2015 Jessie Serrino. All rights reserved.
//

#import "NSURL+Parameters.h"

@implementation NSURL (Parameters)

+ (NSURL *) urlWithBaseString: (NSString *) baseURLString parameters: (NSDictionary *) parameters
{
    NSString *trimmedBaseURL = [baseURLString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
    NSArray *keyValuePairs = [NSURL keyValuePairs:parameters];
    
    NSString *parametersString = [keyValuePairs componentsJoinedByString:@"&"];
    
    NSString*urlString =[NSString stringWithFormat:@"%@?%@", trimmedBaseURL, parametersString];
    return [NSURL URLWithString:urlString];
}

+ (NSArray *) keyValuePairs: (NSDictionary *) parameters
{
    NSMutableArray *keyValuePairs = [[NSMutableArray alloc] initWithCapacity:parameters.count];
    for(NSString *key in parameters){
        NSString *keyValuePair = [NSString stringWithFormat:@"%@=%@", key, parameters[key]];
        [keyValuePairs addObject:keyValuePair];
    }
    return keyValuePairs;
}

@end
