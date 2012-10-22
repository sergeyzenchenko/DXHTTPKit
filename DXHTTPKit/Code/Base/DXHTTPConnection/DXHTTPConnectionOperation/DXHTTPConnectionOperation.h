//
//  DXHTTPConnectionOperation.h
//  DXHTTPKit
//
//  Created by dev2 on 10/22/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXHTTPConnectionThread.h"

@interface DXHTTPConnectionOperation : NSOperation <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

- (id)initWithURLRequest:(NSURLRequest *)aURLRequest;

@property (nonatomic, readonly) NSData *connectionData;
@property (nonatomic, strong, readonly) NSURLConnection *urlConnection;

@end
