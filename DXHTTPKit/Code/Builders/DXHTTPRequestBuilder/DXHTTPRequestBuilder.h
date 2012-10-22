//
//  DXHTTPRequestBuilder.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/18/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXHTTPRequestDescriptor.h"
#import "DXHTTPFormBodyStreamBuilder.h"
#import "DXHTTPFormParamsBuilder.h"
#import "DXHTTPHeadersBuilder.h"
#import "DXHTTPURLRequestAdditionalsBuilder.h"

@interface DXHTTPRequestBuilder : NSObject

- (NSURLRequest *)buildRequest:(DXHTTPRequestDescriptor *)requestDescriptor;

@end
