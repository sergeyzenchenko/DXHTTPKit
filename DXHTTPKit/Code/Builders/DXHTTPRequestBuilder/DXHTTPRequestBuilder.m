//
//  DXHTTPBuilder.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/18/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPRequestBuilder.h"

@implementation DXHTTPRequestBuilder

- (NSURLRequest *)buildRequest:(DXHTTPRequestDescriptor *)requestDescriptor {
    NSURLRequest *urlRequest;
    
    urlRequest = [[DXHTTPURLRequestAdditionalsBuilder alloc] buildAdditionals:requestDescriptor];
    urlRequest = [[DXHTTPFormParamsBuilder alloc] buildParams:requestDescriptor urlRequest:urlRequest];
    urlRequest = [[DXHTTPHeadersBuilder alloc] buildHeaders:requestDescriptor.headers urlRequest:urlRequest];
    
    return urlRequest;
}


@end
