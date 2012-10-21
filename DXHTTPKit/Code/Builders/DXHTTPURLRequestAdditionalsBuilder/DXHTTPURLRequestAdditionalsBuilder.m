//
//  DXHTTPURLRequestAdditionalsBuilder.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/21/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPURLRequestAdditionalsBuilder.h"

@implementation DXHTTPURLRequestAdditionalsBuilder

- (NSURLRequest *)buildAdditionals:(DXHTTPRequestDescriptor *)requestDescrioptor {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest new];
    
    [urlRequest setHTTPMethod:requestDescrioptor.httpMethod];
    [urlRequest setTimeoutInterval:requestDescrioptor.timeOutInterval];
    [urlRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", requestDescrioptor.baseURL, requestDescrioptor.path]]];
    
    return urlRequest;
}

@end
