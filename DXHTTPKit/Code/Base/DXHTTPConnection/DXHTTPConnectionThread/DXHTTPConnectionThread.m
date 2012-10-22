//
//  DXHTTPConnectionThread.m
//  DXHTTPKit
//
//  Created by dev2 on 10/22/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPConnectionThread.h"

@interface DXHTTPConnectionThread()

@end

@implementation DXHTTPConnectionThread

static NSThread *_connectionThread;

+ (void)connectionThreadEntry:(id)object {
    do {
        @autoreleasepool {
            [[NSRunLoop currentRunLoop] run];
        }
    } while (YES);
}

+ (NSThread *)requestConnectionThread {
    static dispatch_once_t allocThreadOnce;
    
    dispatch_once(&allocThreadOnce, ^{
        _connectionThread = [[NSThread alloc] initWithTarget:self selector:@selector(connectionThreadEntry:) object:nil];
        [_connectionThread start];
    });
    return _connectionThread;
}

@end
