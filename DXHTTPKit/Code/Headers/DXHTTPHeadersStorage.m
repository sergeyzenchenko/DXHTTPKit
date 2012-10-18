//
//  DXHTTPHeader.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import "DXHTTPHeadersStorage.h"

@interface DXHTTPHeadersStorage() {
    NSMutableDictionary *_headers;
}

@end

@implementation DXHTTPHeadersStorage


- (void)addHeader:(NSString *)aHeaderKey value:(NSString *)aValue {
    NSParameterAssert([aHeaderKey isKindOfClass:[NSString class]]);
    NSParameterAssert([aHeaderKey length] != 0);
    NSParameterAssert([aValue isKindOfClass:[NSString class]]);
    
    if(_headers == nil) {
        _headers = [[NSMutableDictionary alloc] init];
        NSArray *arrayForValue = @[aValue];
        [_headers setObject:arrayForValue forKey:aHeaderKey];
    } else {
        NSMutableArray *headerValue = [[_headers objectForKey:aHeaderKey] mutableCopy];
        
        if (headerValue) {
            [headerValue addObject:aValue];
            [_headers setObject:headerValue forKey:aHeaderKey];
        } else {
            NSArray *arrayForValue = @[aValue];
            [_headers setObject:arrayForValue forKey:aHeaderKey];
        }
    }
}

- (void)addHeader:(NSString *)aHeaderKey valuesArray:(NSArray *)aValuesArray {
    
    NSParameterAssert([aHeaderKey isKindOfClass:[NSString class]]);
    NSParameterAssert([aHeaderKey length] != 0);
    NSParameterAssert([aValuesArray isKindOfClass:[NSArray class]]);
    
    if(_headers == nil) {
        _headers = [[NSMutableDictionary alloc] init];
        [_headers setObject:aValuesArray forKey:aHeaderKey];
    } else {
        NSMutableArray *headerValue = [[_headers objectForKey:aHeaderKey] mutableCopy];
        
        if (headerValue) {
            for(NSInteger i = 0; i < [aValuesArray count]; ++i)
                [headerValue addObject:[aValuesArray objectAtIndex:i]];
            [_headers setObject:headerValue forKey:aHeaderKey];
        } else {
            [_headers setObject:aValuesArray forKey:aHeaderKey];
        }
    }
}

- (NSDictionary *) headers {
    return _headers;
}
@end
