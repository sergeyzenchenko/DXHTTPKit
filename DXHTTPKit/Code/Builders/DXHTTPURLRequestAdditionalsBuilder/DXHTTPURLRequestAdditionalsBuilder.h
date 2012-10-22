//
//  DXHTTPURLRequestAdditionalsBuilder.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/21/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXHTTPRequestDescriptor.h"

@interface DXHTTPURLRequestAdditionalsBuilder : NSObject

- (NSURLRequest *)buildAdditionals:(DXHTTPRequestDescriptor *)requestDescrioptor;

@end
