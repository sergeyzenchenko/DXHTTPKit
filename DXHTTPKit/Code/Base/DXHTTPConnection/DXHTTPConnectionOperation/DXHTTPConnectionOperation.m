//
//  DXHTTPConnectionOperation.m
//  DXHTTPKit
//
//  Created by dev2 on 10/22/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPConnectionOperation.h"

@interface DXHTTPConnectionOperation() {
    NSURLRequest *_urlRequest;
    NSURLConnection *_urlConnection;
    NSMutableData *_connectionData;
    NSMutableDictionary *_connectionResponseHeaders;
    BOOL _executing;
    BOOL _finished;
}

@end

@implementation DXHTTPConnectionOperation

- (id)initWithURLRequest:(NSURLRequest *)aURLRequest {
    self = [super init];
    if (self) {
        _urlRequest = aURLRequest;
        _connectionData = [NSMutableData new];
    }
    return self;
}

- (void)start {
    _executing = YES;
    [self performSelector:@selector(connectionOpeartionDidStart) onThread:[DXHTTPConnectionThread requestConnectionThread] withObject:nil waitUntilDone:NO];
    
}

- (void)connectionOpeartionDidStart {
    _urlConnection = [[NSURLConnection alloc] initWithRequest:_urlRequest delegate:self];
    NSRunLoop *connectionRunLoop = [NSRunLoop currentRunLoop];
    [_urlConnection scheduleInRunLoop:connectionRunLoop forMode:NSRunLoopCommonModes];
    [_urlConnection start];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_connectionData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_connectionData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}

- (NSData *)connectionData {
    return _connectionData;
}

- (NSURLConnection *)urlConnection {
    return _urlConnection;
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (BOOL)isConcurrent {
    return YES;
}

@end
