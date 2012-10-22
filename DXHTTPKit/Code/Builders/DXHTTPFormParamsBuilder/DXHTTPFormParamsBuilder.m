//
//  DXHTTPFormParamBuilder.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/19/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPFormParamsBuilder.h"

@implementation DXHTTPFormParamsBuilder

- (NSURLRequest *)buildParams:(DXHTTPRequestDescriptor *)requestDescriptor urlRequest:(NSURLRequest *)aURLRequest {
    
    NSMutableURLRequest *urlRequest = [aURLRequest mutableCopy];
    NSMutableArray *filesArray = [NSMutableArray new];;
    NSMutableArray *paramsArray = [NSMutableArray new];;
    
    for (DXHTTPFormParam *formParam in requestDescriptor.params) {
        if ([formParam.value isKindOfClass:[NSString class]]) {
            [paramsArray addObject:formParam];
        }
        else if ([formParam.value isKindOfClass:[DXHTTPFormFileDescriptor class]]) {
            [filesArray addObject:formParam];
        }
    }
    
    if (![[urlRequest HTTPMethod] isEqual:DXHTTPMethod.POST] && ![[urlRequest HTTPMethod] isEqual:DXHTTPMethod.PUT]) {
        DXParametrAssert([filesArray count] == 0, DXHTTPKitErrors.FilesOnNonPostMethod);
    }
    
    if ([[urlRequest HTTPMethod] isEqualToString:@"POST"]) {
        DXHTTPFormBodyStreamBuilder *bodyStream = [[DXHTTPFormBodyStreamBuilder alloc] initWithFiles:filesArray paramsArray:paramsArray];
        [bodyStream buildStream];
        [urlRequest setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", [bodyStream boundary]] forHTTPHeaderField:@"Content-Type"];
        [urlRequest setValue:[NSString stringWithFormat:@"%d", [bodyStream length]] forHTTPHeaderField:@"Content-Length"];
        
        [urlRequest setHTTPBodyStream:bodyStream];
    } else if ([[urlRequest HTTPMethod]isEqualToString:@"GET"]) {
        NSMutableString *paramsString = [NSMutableString new];
        
        [paramsString insertString:@"?" atIndex:0];
        [paramsString appendFormat:@"%@", [paramsArray componentsJoinedByString:@"&"]];
        NSString *currentURL = [[urlRequest URL] absoluteString];
        [urlRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", currentURL, paramsString]]];
    }
    return urlRequest;
}

@end
