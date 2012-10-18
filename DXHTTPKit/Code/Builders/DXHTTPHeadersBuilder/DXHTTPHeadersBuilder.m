//
//  DXHTTPHeadersBuilder.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/19/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPHeadersBuilder.h"

@implementation DXHTTPHeadersBuilder

- (NSURLRequest *)buildHeaders:(NSDictionary *)headers urlRequest:(NSURLRequest *)aUrlRequest {
    NSMutableURLRequest *urlRequest = [aUrlRequest mutableCopy];
    NSArray *headersKeys = [headers allKeys];
    
    for (NSInteger i = 0; i < [headersKeys count]; ++i) {
        NSMutableString *headerValue = [NSMutableString new];
        NSArray *headerValues = [headers objectForKey: headersKeys[i]];
        NSInteger j = 0;
        for (j = 0; j < [headerValues count] - 1; ++j)
                [headerValue appendFormat:@"%@; ", headerValues[j]];
        [headerValue appendString:headerValues[j]];
        
        [urlRequest setValue:headerValue forHTTPHeaderField:headersKeys[i]];
    }
    return urlRequest;
}

@end
