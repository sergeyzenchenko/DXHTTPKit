//
//  DXHTTPFormFileElement.h
//  DXHTTPKit
//
//  Created by dev2 on 10/20/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#ifndef min
#define min(a,b) ((a) < (b) ? (a) : (b))
#endif

#import <Foundation/Foundation.h>
#import "DXHTTPFormParam.h"
#import "DXHTTPFormFileDescriptor.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface DXHTTPFormPartElement : NSObject

- (id)initWithFormFileParam:(DXHTTPFormParam *)fileParam  boundary:(NSString *)boundary;
- (id)initWithFormParam:(DXHTTPFormParam *)formParam  boundary:(NSString *)boundary;

@property (nonatomic, readonly) NSUInteger partLenght;

@end
