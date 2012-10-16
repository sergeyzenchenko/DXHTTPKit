//
//  DXHTTPHeader.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import "DXHTTPHeadersStorage.h"

@interface DXHTTPHeadersStorage()

@property (nonatomic, strong, readwrite) NSMutableDictionary *headers;

@end

@implementation DXHTTPHeadersStorage

- (void)addHeader:(NSString *)aHeaderKey value:(NSArray *)aValue {
    
    NSParameterAssert([aHeaderKey isKindOfClass:[NSString class]]);
    NSParameterAssert([aHeaderKey length] != 0);
    NSParameterAssert([aValue isKindOfClass:[NSArray class]]);
    
    if(self.headers == nil) {
        self.headers = [[NSMutableDictionary alloc] init];
        [self.headers setObject:aValue forKey:aHeaderKey];
    } else {
        NSMutableArray *headerValue = [[_headers objectForKey:aHeaderKey] mutableCopy];
        
        if (headerValue) {
            [headerValue addObject:aValue];
            [self.headers setObject:headerValue forKey:aHeaderKey];
        } else {
            [self.headers setObject:aValue forKey:aHeaderKey];
        }
    }
}
@end
