//
//  DXHTTPHeadersBuilder.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/19/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXHTTPHeadersStorage.h"

@interface DXHTTPHeadersBuilder : NSObject

- (NSURLRequest *)buildHeaders:(NSDictionary *)headers urlRequest:(NSURLRequest *)aUrlRequest;

@end
