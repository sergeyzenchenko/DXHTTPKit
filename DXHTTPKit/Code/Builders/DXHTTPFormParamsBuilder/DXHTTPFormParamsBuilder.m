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
    NSMutableArray *fileArray = [NSMutableArray new];;
    NSMutableArray *paramsArray = [NSMutableArray new];;
    
    NSMutableString *paramsString = [[NSMutableString alloc] initWithString:@"?"];
    
    for (DXHTTPFormParam *formParam in requestDescriptor.params)
        if ([formParam.value isKindOfClass:[NSString class]])
            [paramsArray addObject:formParam];
        else
            [fileArray addObject:formParam];
    
    [paramsString appendFormat:@"%@", [paramsArray componentsJoinedByString:@"&"]];
    
    [urlRequest setHTTPMethod:requestDescriptor.httpMethod];
    
    if ([[urlRequest HTTPMethod] isEqualToString:@"POST"]) {
        [urlRequest setHTTPBody:[paramsString dataUsingEncoding:NSUTF8StringEncoding]];
    } else
        [urlRequest setURL:[NSURL URLWithString:paramsString]];
    
    return urlRequest;
}

@end
