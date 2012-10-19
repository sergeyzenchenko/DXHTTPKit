//
//  DXHTTPFormParamBuilder.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/19/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXHTTPRequestDescriptor.h"

@interface DXHTTPFormParamsBuilder : NSObject

- (NSURLRequest *)buildParams:(DXHTTPRequestDescriptor *)requestDescriptor;

@end
