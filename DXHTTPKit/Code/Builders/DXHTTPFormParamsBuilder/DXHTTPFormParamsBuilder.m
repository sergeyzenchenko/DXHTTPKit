//
//  DXHTTPFormParamBuilder.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/19/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPFormParamsBuilder.h"

@implementation DXHTTPFormParamsBuilder

- (NSURLRequest *)buildParams:(DXHTTPRequestDescriptor *)requestDescriptor {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest new];
    
    NSMutableString *paramsString = [[NSMutableString alloc] initWithString:@"?"];
    
    [paramsString appendFormat:@"%@", [requestDescriptor.params componentsJoinedByString:@"&"]];
    paramsString = [[paramsString stringByReplacingOccurrencesOfString:@"&&" withString:@"&"] mutableCopy];
    
    [urlRequest setHTTPMethod:requestDescriptor.httpMethod];
    
    if ([[urlRequest HTTPMethod] isEqualToString:@"POST"]) {
        [urlRequest setHTTPBody:[paramsString dataUsingEncoding:NSUTF8StringEncoding]];
    } else
        [urlRequest setURL:[NSURL URLWithString:paramsString]];
    
    return urlRequest;
}

@end
