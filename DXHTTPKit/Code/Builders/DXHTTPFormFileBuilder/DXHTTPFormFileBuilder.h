//
//  DXHTTPFormFileBuilder.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/20/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXHTTPRequestDescriptor.h"

@interface DXHTTPFormFileBuilder : NSObject

- (NSInputStream *)buildFileStream:(DXHTTPFormFileDescriptor *)fileDescriptor;

@end
