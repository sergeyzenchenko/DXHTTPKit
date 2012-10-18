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

- (id)init {
    self = [super init];
    if (self) {
        _headers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addHeader:(NSString *)aHeaderKey value:(id)aValue {
    
    NSParameterAssert([aHeaderKey isKindOfClass:[NSString class]]);
    NSParameterAssert([aHeaderKey length] != 0);
    NSParameterAssert([[self class] isAllowedClassForHeaderValueField:[aValue class]]);
    
    NSMutableArray *headerValue = [[_headers objectForKey:aHeaderKey] mutableCopy];
    
    if (headerValue) {
        if ([aValue isKindOfClass: [NSString class]]) {
            [headerValue addObject:aValue];
        } else {
            for (NSInteger i = 0; i < [aValue count]; ++i)
                [headerValue addObject: aValue[i]];
        }
        [_headers setObject:headerValue forKey:aHeaderKey];
    } else {
        if ([aValue isKindOfClass:[NSString class]]) {
            [_headers setObject:@[aValue] forKey:aHeaderKey];
        } else {
            [_headers setObject:aValue forKey:aHeaderKey];
        }
    }
}

- (NSDictionary *) headers {
    return _headers;
}
@end
