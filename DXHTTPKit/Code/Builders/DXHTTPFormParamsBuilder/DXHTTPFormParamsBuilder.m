//
//  DXHTTPFormParamBuilder.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/19/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPFormParamsBuilder.h"
#import "DXHTTPFormFileBuilder.h"

@implementation DXHTTPFormParamsBuilder

- (NSURLRequest *)buildParams:(DXHTTPRequestDescriptor *)requestDescriptor {
    DXParametrAssert([requestDescriptor.httpMethod length], DXHTTPErrors.HTTPMethodIsEmpty);
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest new];
    NSMutableArray *fileArray = [NSMutableArray new];;
    NSMutableArray *paramsArray = [NSMutableArray new];;
    
    NSMutableString *paramsString = [NSMutableString new];
    
    for (DXHTTPFormParam *formParam in requestDescriptor.params)
        if ([formParam.value isKindOfClass:[NSString class]])
            [paramsArray addObject:formParam];
        else if ([formParam.value isKindOfClass:[DXHTTPFormFileDescriptor class]])
            [fileArray addObject:formParam];
    
    [paramsString appendFormat:@"%@", [paramsArray componentsJoinedByString:@"&"]];
    
    [urlRequest setHTTPMethod:requestDescriptor.httpMethod];
    
    if ([[urlRequest HTTPMethod] isEqualToString:@"POST"]) {
        NSMutableArray *filesStreams = [NSMutableArray new];
        
        for (DXHTTPFormParam *fileParam in fileArray) {
            DXHTTPFormFileBuilder *fileBuilder = [DXHTTPFormFileBuilder new];
            NSInputStream * fileStream = [fileBuilder buildFileStream:fileParam.value];
            
            [filesStreams addObject:fileStream];
        }
        [urlRequest setHTTPBody:[paramsString dataUsingEncoding:NSUTF8StringEncoding]];
    } else if ([[urlRequest HTTPMethod]isEqualToString:@"GET"])
        [paramsString insertString:@"?" atIndex:0];
        [urlRequest setURL:[NSURL URLWithString:paramsString]];
    
    return urlRequest;
}

@end
